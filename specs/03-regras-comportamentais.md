# 03 — Regras Comportamentais

## Resumo

Motor de regras simples que detecta padrões de uso e dispara sugestões. Sem ML, sem LLM — apenas thresholds fixos.

## Arquitetura

```
UsageMonitor → RuleEngine → ConversationStub → SuggestionPipeline → Notification/Overlay
```

## Regra A: Inquietação na Tela (Screen Restlessness)

| Parâmetro | Valor |
|-----------|-------|
| ID | `rule_screen_restlessness` |
| Trigger | Tela ligada/desligada ≥ 6 vezes em 15 minutos |
| Cooldown | 2 horas entre disparos da mesma regra |
| Mensagem EN | "Take a short break? You've been using your phone quite a bit today." |
| Mensagem PT | "Que tal uma pausa? Você usou bastante o celular hoje." |
| Explicação EN | "Because you turned your screen on/off %d times in %d minutes" |
| Explicação PT | "Porque você ligou/desligou a tela %d vezes em %d minutos" |

## Regra B: Foco no WhatsApp

| Parâmetro | Valor |
|-----------|-------|
| ID | `rule_whatsapp_focus` |
| Trigger | WhatsApp aberto ≥ 3 vezes em 30 minutos |
| Cooldown | 3 horas |
| Mensagem EN | "Need to reach someone important? You've opened WhatsApp quite a bit." |
| Mensagem PT | "Precisa falar com alguém importante? Você abriu o WhatsApp bastante." |
| Explicação EN | "Because you opened WhatsApp %d times in %d minutes" |
| Explicação PT | "Porque você abriu o WhatsApp %d vezes em %d minutos" |

## Regra C: Lazer Noturno (Evening Leisure)

| Parâmetro | Valor |
|-----------|-------|
| ID | `rule_evening_leisure` |
| Trigger | ≥ 45 min em apps sociais após 21:00 |
| Apps monitorados | Instagram, TikTok, Twitter/X, Facebook |
| Cooldown | 1 vez por noite |
| Mensagem EN | "Want to relax with something else? You've been on social media quite a bit." |
| Mensagem PT | "Quer relaxar com outra coisa? Você ficou bastante nas redes sociais." |
| Explicação EN | "Because you spent %d minutes on social apps after 9 PM" |
| Explicação PT | "Porque você passou %d minutos em apps sociais após 21h" |

## RuleEngine (Custom Action)

```dart
class RuleEngine {
  final List<BehaviorRule> rules = [
    ScreenRestlessnessRule(),
    WhatsAppFocusRule(),
    EveningLeisureRule(),
  ];

  Suggestion? evaluate(UsageSnapshot snapshot, AppSettings settings) {
    if (settings.isSnoozed) return null;
    if (settings.dailySuggestionCount >= settings.maxSuggestionsPerDay) return null;

    for (final rule in rules) {
      if (rule.canFire(snapshot) && !rule.isInCooldown()) {
        return rule.createSuggestion(snapshot, settings.language);
      }
    }
    return null;
  }
}
```

## Limites de sugestão

| Modo | Sugestões/dia | Chave |
|------|---------------|-------|
| Basic | 1-2 (média 2) | `intensity = "basic"` |
| Proactive | até 4 (média 4) | `intensity = "proactive"` |
| Hard cap global | máximo 5 | sempre |

## Pipeline de sugestão

1. `UsageMonitor` coleta eventos (app foreground, screen on/off)
2. A cada intervalo (5 min), `RuleEngine.evaluate()` roda
3. Se sugestão gerada:
   - Salvar `Suggestion` no banco
   - Incrementar contador diário
   - Publicar no widget
   - Agendar notificação local
   - Atualizar avatar para estado `suggest`
4. Registrar cooldown da regra

## Dados de entrada (UsageSnapshot)

```dart
class UsageSnapshot {
  DateTime windowStart;
  DateTime windowEnd;
  int screenOnOffCount;
  Map<String, int> appOpenCounts;  // bundleId → count
  Map<String, int> appDurations;   // bundleId → seconds
}
```

## Custom Actions necessárias

| Action | Descrição |
|--------|-----------|
| `startUsageMonitor` | Inicia coleta de eventos de uso |
| `evaluateRules` | Roda RuleEngine com snapshot atual |
| `createSuggestion` | Persiste sugestão e dispara pipeline |
| `resetDailyCounters` | Reset à meia-noite |

## Limitações de plataforma

| Plataforma | Detecção de apps | Solução MVP |
|------------|------------------|-------------|
| Android | UsageStats API | Custom action com permissão PACKAGE_USAGE_STATS |
| iOS | Screen Time API (restrito) | Simular com eventos in-app + notificações |

**Nota**: Detecção real de apps em background é limitada em iOS. No MVP, focar em eventos dentro do app + notificações como canal principal de sugestão.

## Critérios de aceite

- [ ] 3 regras implementadas com thresholds corretos
- [ ] Cooldown funciona por regra
- [ ] Limites diários respeitados (basic/proactive/cap)
- [ ] Snooze bloqueia todas as regras
- [ ] Toda sugestão tem explicação "Por quê?"
- [ ] Sugestões salvas com ruleId, sessionId, timestamp
- [ ] Contador diário reseta à meia-noite
