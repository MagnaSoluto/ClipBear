# 04 — Conversa Stub

## Resumo

Sistema de frases pré-definidas em EN/PT. Sem LLM — sempre fallback para frases fixas. Categorias: reflexiva, humorística, prática.

## Arquitetura

```dart
class ConversationStub {
  String getPhrase(PhraseCategory category, String language, String ruleId);
}
```

## Categorias

| Categoria | Tom | Exemplo EN | Exemplo PT |
|-----------|-----|------------|------------|
| `reflective` | Pensativo, empático | "You've been quite active today. Everything okay?" | "Você esteve bem ativo hoje. Tudo bem?" |
| `humorous` | Leve, divertido | "Your phone misses you when you put it down... or does it?" | "Seu celular sente sua falta quando você larga ele... ou não?" |
| `practical` | Direto, útil | "Take a short break?" | "Que tal uma pausa?" |

## Mapeamento regra → categoria

| Regra | Categoria padrão |
|-------|------------------|
| `rule_screen_restlessness` | `practical` |
| `rule_whatsapp_focus` | `reflective` |
| `rule_evening_leisure` | `humorous` |

## Frases por regra (definitivas do MVP)

### rule_screen_restlessness

| Lang | Mensagem |
|------|----------|
| EN | "Take a short break? You've been using your phone quite a bit today." |
| PT | "Que tal uma pausa? Você usou bastante o celular hoje." |

### rule_whatsapp_focus

| Lang | Mensagem |
|------|----------|
| EN | "Need to reach someone important? You've opened WhatsApp quite a bit." |
| PT | "Precisa falar com alguém importante? Você abriu o WhatsApp bastante." |

### rule_evening_leisure

| Lang | Mensagem |
|------|----------|
| EN | "Want to relax with something else? You've been on social media quite a bit." |
| PT | "Quer relaxar com outra coisa? Você ficou bastante nas redes sociais." |

### demo_food_order

| Lang | Mensagem |
|------|----------|
| EN | "Shall I order food for you?" |
| PT | "Quer que eu peça comida para você?" |

### demo_table_booking

| Lang | Mensagem |
|------|----------|
| EN | "Want me to book a table somewhere?" |
| PT | "Quer que eu reserve uma mesa para você?" |

## Formato de armazenamento

```json
{
  "phrases": [
    {
      "id": "screen_restlessness_practical",
      "ruleId": "rule_screen_restlessness",
      "category": "practical",
      "en": "Take a short break?...",
      "pt": "Que tal uma pausa?..."
    }
  ]
}
```

Arquivo: `assets/data/phrases.json`

## Custom Action

```dart
Future<String> getPhrase(
  String ruleId,
  String language,
  {PhraseCategory? categoryOverride}
) async {
  // 1. Buscar frase por ruleId + language
  // 2. Se categoryOverride, buscar por categoria
  // 3. Fallback: primeira frase da regra
}
```

## Critérios de aceite

- [ ] Todas as frases disponíveis em EN e PT
- [ ] Mapeamento regra → frase funciona
- [ ] Fallback sempre retorna frase (nunca vazio)
- [ ] Frases carregadas de JSON (fácil de editar)
- [ ] Sem chamadas de rede
