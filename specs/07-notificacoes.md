# 07 — Notificações

## Resumo

Notificações locais para entregar sugestões quando o app está em background. Ações inline: aceitar/rejeitar.

## Tipos de notificação

| Tipo | ID | Quando |
|------|----|--------|
| Sugestão | `suggestion` | RuleEngine dispara nova sugestão |
| Snooze expirado | `snooze_expired` | Snooze termina (opcional) |

## Notificação de sugestão

```
┌─────────────────────────────────────┐
│ 🐻 ClipBear                         │
│ Tinker diz: "Que tal uma pausa?"    │
│ Porque você ligou a tela 8x em 15min│
│                                     │
│ [👍 Aceitar]  [👎 Rejeitar]         │
└─────────────────────────────────────┘
```

## Ações da notificação

| Ação | ID | Comportamento |
|------|----|---------------|
| Aceitar | `ACCEPT` | Registra feedback positivo, abre app |
| Rejeitar | `REJECT` | Registra feedback negativo |

## Implementação

- Package: `flutter_local_notifications`
- Custom Action: `scheduleSuggestionNotification(suggestion)`
- Custom Action: `handleNotificationAction(actionId, suggestionId)`

## Fluxo

1. RuleEngine cria sugestão
2. `scheduleSuggestionNotification()` agenda notificação
3. Usuário vê notificação
4. Tap na notificação → abre app na tela principal com sugestão
5. Aceitar/Rejeitar → salva `SuggestionFeedback`, atualiza `Suggestion.isAccepted`

## Permissões

- Solicitar no onboarding (etapa 3)
- Se negada: sugestões só aparecem in-app (sem push)
- Re-solicitar nas configurações se necessário

## Localização

| Chave | EN | PT |
|-------|----|----|
| `notification.accept` | 👍 Accept | 👍 Aceitar |
| `notification.reject` | 👎 Reject | 👎 Rejeitar |

## Critérios de aceite

- [ ] Notificação exibe mensagem + explicação
- [ ] Ações aceitar/rejeitar funcionam inline
- [ ] Tap abre app com sugestão visível
- [ ] Feedback salvo corretamente
- [ ] Funciona com app em background
- [ ] Strings localizadas EN/PT
- [ ] Sem notificação se snoozed ou limite atingido
