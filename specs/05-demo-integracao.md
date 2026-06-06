# 05 — Demo de Integração Falsa

## Resumo

Fluxos de demonstração que simulam integrações reais (pedir comida, reservar mesa) para validar se usuários gostam de um "companheiro que age".

## Demos disponíveis

### Demo 1: Pedir Comida

| Etapa | Tela | Conteúdo |
|-------|------|----------|
| 1 | Seleção | Botão "🍕 Pedir Comida" com descrição |
| 2 | Confirmação | "Quer que eu peça comida para você?" [Sim] [Não] |
| 3 | Processando | Spinner 2s (simulado) |
| 4 | Resultado | "🍕 Pedido confirmado! (Demo - não é real)" |

### Demo 2: Reservar Mesa

| Etapa | Tela | Conteúdo |
|-------|------|----------|
| 1 | Seleção | Botão "🍽️ Reservar Mesa" com descrição |
| 2 | Confirmação | "Quer que eu reserve uma mesa?" [Sim] [Não] |
| 3 | Processando | Spinner 2s (simulado) |
| 4 | Resultado | "🍽️ Mesa reservada com sucesso! (Demo - não é real)" |

## Fluxo de navegação

```
Main → DemoSelection → DemoConfirmation → DemoProcessing → DemoResult → Main
```

## Páginas FlutterFlow

| Página | Rota | Tipo |
|--------|------|------|
| DemoSelection | `/demo` | Bottom sheet ou página |
| DemoConfirmation | `/demo/confirm` | Dialog |
| DemoProcessing | `/demo/processing` | Overlay com spinner |
| DemoResult | `/demo/result` | Snackbar ou dialog |

## Registro de métricas

Ao completar demo, registrar:

```dart
SuggestionFeedback {
  id: UUID,
  ruleId: "demo_food_order" | "demo_table_booking",
  sessionId: currentSession,
  accepted: true,  // usuário clicou Sim
  timestamp: DateTime.now()
}
```

## Acesso

- Botões na tela principal: "🍕 Pedir Comida" / "🍽️ Reservar Mesa"
- Seção "Demo Actions" com descrição "Experimente integrações falsas"

## Critérios de aceite

- [ ] 2 demos funcionais com fluxo completo
- [ ] Spinner de processamento (2s simulado)
- [ ] Mensagem clara de que é demo (não real)
- [ ] Feedback registrado ao aceitar
- [ ] Strings localizadas EN/PT
- [ ] Nenhuma chamada de rede
