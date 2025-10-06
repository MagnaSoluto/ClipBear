#!/bin/bash

# ClipBear Force Rebuild - Força recompilação completa
# Para resolver problemas de localização e navegação

echo "🔄 ClipBear Force Rebuild"
echo "========================="
echo ""

# Verificar se estamos no diretório correto
if [ ! -f "ClipBear.xcodeproj/project.pbxproj" ]; then
    echo "❌ Erro: Execute este script do diretório ios/ClipBear"
    echo "   cd ios/ClipBear"
    echo "   ./force_rebuild.sh"
    exit 1
fi

echo "🧹 1. Limpeza completa..."
# Limpar tudo
xcodebuild clean -project ClipBear.xcodeproj -scheme ClipBear -quiet
rm -rf ~/Library/Developer/Xcode/DerivedData/ClipBear-*
rm -rf ~/Library/Caches/com.apple.dt.Xcode

echo "📱 2. Parando simulador..."
# Parar simulador
xcrun simctl shutdown "iPhone 17 Pro" 2>/dev/null || true
xcrun simctl shutdown "iPhone 17" 2>/dev/null || true

echo "🔨 3. Compilação forçada..."
# Compilar com flags de debug
xcodebuild -project ClipBear.xcodeproj -scheme ClipBear -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build -quiet

if [ $? -ne 0 ]; then
    echo "❌ Erro na compilação!"
    exit 1
fi

echo "✅ Compilação bem-sucedida!"

echo "📱 4. Iniciando simulador..."
# Iniciar simulador
xcrun simctl boot "iPhone 17 Pro"
sleep 3

echo "📲 5. Instalando app..."
# Encontrar e instalar app
APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData -name "ClipBear.app" -path "*/Debug-iphonesimulator/*" | grep -v Index.noindex | head -1)

if [ -z "$APP_PATH" ]; then
    echo "❌ App não encontrado!"
    exit 1
fi

echo "📱 App encontrado: $APP_PATH"

# Instalar
xcrun simctl install "iPhone 17 Pro" "$APP_PATH"

if [ $? -ne 0 ]; then
    echo "❌ Erro na instalação!"
    exit 1
fi

echo "✅ App instalado!"

echo "🚀 6. Iniciando app com logs..."
# Iniciar com logs
xcrun simctl launch "iPhone 17 Pro" com.clipbear.mvp

if [ $? -eq 0 ]; then
    echo "✅ App iniciado!"
    echo ""
    echo "📱 O app deve estar rodando no simulador agora."
    echo ""
    echo "🔍 Para ver logs em tempo real:"
    echo "   xcrun simctl spawn \"iPhone 17 Pro\" log stream --predicate 'process == \"ClipBear\"'"
    echo ""
    echo "🛑 Para parar o app:"
    echo "   xcrun simctl terminate \"iPhone 17 Pro\" com.clipbear.mvp"
    echo ""
    echo "📋 Teste:"
    echo "   1. Verifique se os textos estão em português"
    echo "   2. Navegue pelas telas"
    echo "   3. Aceite os termos"
    echo "   4. Verifique se vai para a tela principal"
else
    echo "❌ Erro ao iniciar o app!"
    exit 1
fi
