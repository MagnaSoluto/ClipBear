#!/bin/bash

# ClipBear Test Script - Versão Simples
# Para usuários sem experiência com Xcode

echo "🧪 ClipBear Test Script"
echo "======================"
echo ""

# Verificar se estamos no diretório correto
if [ ! -f "ClipBear.xcodeproj/project.pbxproj" ]; then
    echo "❌ Erro: Execute este script do diretório ios/ClipBear"
    echo "   cd ios/ClipBear"
    echo "   ./test_app.sh"
    exit 1
fi

echo "📱 1. Limpando build anterior..."
xcodebuild clean -project ClipBear.xcodeproj -scheme ClipBear -quiet

echo "🔨 2. Compilando o app..."
xcodebuild -project ClipBear.xcodeproj -scheme ClipBear -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build -quiet

if [ $? -ne 0 ]; then
    echo "❌ Erro na compilação! Verifique os erros acima."
    exit 1
fi

echo "✅ Compilação bem-sucedida!"

echo "📱 3. Verificando simulador..."
DEVICE_ID=$(xcrun simctl list devices | grep "iPhone 17 Pro" | grep "Booted" | head -1 | sed 's/.*(\([^)]*\)).*/\1/')

if [ -z "$DEVICE_ID" ]; then
    echo "📱 Iniciando simulador iPhone 17 Pro..."
    xcrun simctl boot "iPhone 17 Pro"
    sleep 5
    DEVICE_ID=$(xcrun simctl list devices | grep "iPhone 17 Pro" | grep "Booted" | head -1 | sed 's/.*(\([^)]*\)).*/\1/')
fi

echo "📱 Simulador: $DEVICE_ID"

echo "📲 4. Instalando app..."
APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData -name "ClipBear.app" -path "*/Debug-iphonesimulator/*" | grep -v Index.noindex | head -1)
xcrun simctl install "$DEVICE_ID" "$APP_PATH"

if [ $? -ne 0 ]; then
    echo "❌ Erro na instalação!"
    exit 1
fi

echo "✅ App instalado!"

echo "🚀 5. Iniciando app..."
xcrun simctl launch "$DEVICE_ID" com.clipbear.mvp

if [ $? -eq 0 ]; then
    echo "✅ App iniciado com sucesso!"
    echo ""
    echo "📱 O app deve estar rodando no simulador agora."
    echo "   Se não aparecer, verifique a tela do simulador."
    echo ""
    echo "🔍 Para verificar se está rodando:"
    echo "   ps aux | grep ClipBear | grep -v grep"
    echo ""
    echo "🛑 Para parar o app:"
    echo "   xcrun simctl terminate \"$DEVICE_ID\" com.clipbear.mvp"
else
    echo "❌ Erro ao iniciar o app!"
    exit 1
fi
