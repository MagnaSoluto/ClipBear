# 10 — Localização (i18n)

## Resumo

Suporte completo a Inglês (EN) e Português (PT). Todas as strings externalizadas.

## Idiomas suportados

| Código | Idioma | Locale |
|--------|--------|--------|
| `en` | English | en_US |
| `pt` | Português | pt_BR |

## Implementação FlutterFlow

1. **FlutterFlow i18n**: Configurar em Project Settings → Languages
2. **Arquivos**: `lib/flutter_flow/internationalization.dart` (gerado)
3. **Alternativa**: JSON em `assets/data/strings/` + custom getter

## Detecção automática

```dart
String detectLanguage() {
  final locale = Platform.localeName; // "pt_BR", "en_US"
  if (locale.startsWith('pt')) return 'pt';
  return 'en';
}
```

## Troca manual

- Toggle EN/PT no onboarding e nas configurações
- Persiste em `AppSettings.language`
- Atualiza toda a UI imediatamente

## Chaves de strings

Total: ~87 chaves organizadas por seção.

Ver arquivos completos:
- [strings/en.json](strings/en.json)
- [strings/pt.json](strings/pt.json)

## Seções

| Prefixo | Seção | Qtd |
|---------|-------|-----|
| `onboarding.*` | Onboarding | 8 |
| `button.*` | Botões | 5 |
| `language.*` | Idioma | 3 |
| `main.*` | Tela principal | 12 |
| `settings.*` | Configurações | 14 |
| `suggestion.*` | Sugestões | 5 |
| `explanation.*` | Explicabilidade | 3 |
| `demo.*` | Demos | 7 |
| `feedback.*` | Feedback | 4 |
| `notification.*` | Notificações | 2 |
| `accessibility.*` | Acessibilidade | 16 |

## Formatação com parâmetros

```
explanation.screen_restlessness = "Because you turned your screen on/off %d times in %d minutes"
explanation.whatsapp_focus = "Because you opened WhatsApp %d times in %d minutes"
explanation.evening_leisure = "Because you spent %d minutes on social apps after 9 PM"
```

## Critérios de aceite

- [ ] 100% das strings externalizadas (zero hardcoded)
- [ ] Troca EN/PT reflete imediatamente
- [ ] Detecção automática funciona
- [ ] Strings com parâmetros formatam corretamente
- [ ] Nenhuma chave faltando em um idioma
