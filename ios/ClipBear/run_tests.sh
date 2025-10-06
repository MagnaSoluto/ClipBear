#!/bin/bash

# Script para executar testes do ClipBear iOS
# Uso: ./run_tests.sh [unit|ui|widget|all]

echo "🚀 ClipBear iOS - Executando Testes"
echo "=================================="

# Verificar se o Xcode está instalado
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Xcode não encontrado. Instale o Xcode primeiro."
    exit 1
fi

# Função para executar testes unitários
run_unit_tests() {
    echo "🧪 Executando Testes Unitários..."
    xcodebuild test \
        -scheme ClipBear \
        -destination 'platform=iOS Simulator,name=iPhone 15' \
        -only-testing:ClipBearTests
}

# Função para executar testes de UI
run_ui_tests() {
    echo "🎨 Executando Testes de UI..."
    xcodebuild test \
        -scheme ClipBear \
        -destination 'platform=iOS Simulator,name=iPhone 15' \
        -only-testing:ClipBearUITests
}

# Função para executar testes de widget
run_widget_tests() {
    echo "📱 Executando Testes de Widget..."
    xcodebuild test \
        -scheme ClipBear \
        -destination 'platform=iOS Simulator,name=iPhone 15' \
        -only-testing:ClipBearWidgetTests
}

# Função para executar todos os testes
run_all_tests() {
    echo "🎯 Executando Todos os Testes..."
    xcodebuild test \
        -scheme ClipBear \
        -destination 'platform=iOS Simulator,name=iPhone 15'
}

# Função para limpar e buildar
clean_and_build() {
    echo "🧹 Limpando e Buildando..."
    xcodebuild clean -scheme ClipBear
    xcodebuild build -scheme ClipBear -destination 'platform=iOS Simulator,name=iPhone 15'
}

# Processar argumentos
case "${1:-all}" in
    "unit")
        run_unit_tests
        ;;
    "ui")
        run_ui_tests
        ;;
    "widget")
        run_widget_tests
        ;;
    "all")
        run_all_tests
        ;;
    "clean")
        clean_and_build
        ;;
    *)
        echo "Uso: $0 [unit|ui|widget|all|clean]"
        echo ""
        echo "  unit   - Executa apenas testes unitários"
        echo "  ui     - Executa apenas testes de UI"
        echo "  widget - Executa apenas testes de widget"
        echo "  all    - Executa todos os testes (padrão)"
        echo "  clean  - Limpa e builda o projeto"
        exit 1
        ;;
esac

echo ""
echo "✅ Testes concluídos!"

