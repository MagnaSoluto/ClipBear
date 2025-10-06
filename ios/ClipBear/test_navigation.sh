#!/bin/bash

# ClipBear Navigation Test - Teste interativo de navegação
# Para verificar se a localização e navegação estão funcionando

echo "🧪 ClipBear Navigation Test"
echo "==========================="
echo ""

# Verificar se app está rodando
if ! ps aux | grep ClipBear | grep -v grep > /dev/null; then
    echo "❌ App não está rodando. Execute primeiro:"
    echo "   ./force_rebuild.sh"
    exit 1
fi

echo "✅ App está rodando!"
echo ""

echo "📱 INSTRUÇÕES DE TESTE:"
echo "======================="
echo ""
echo "1. 📱 Olhe para o simulador iPhone 17 Pro"
echo "2. 🔍 Verifique se os textos estão em PORTUGUÊS (não chaves como 'button.next')"
echo "3. 🧭 Teste a navegação:"
echo "   - Clique em 'Próximo' para avançar"
echo "   - Clique em 'Voltar' para voltar"
echo "4. ✅ Na última tela, marque 'I Accept' e clique 'Começar'"
echo "5. 🎯 Verifique se vai para a tela principal"
echo ""

echo "🔍 LOGS EM TEMPO REAL:"
echo "======================"
echo "Pressione Ctrl+C para parar os logs"
echo ""

# Mostrar logs em tempo real
xcrun simctl spawn "iPhone 17 Pro" log stream --predicate 'process == "ClipBear"' --style compact
