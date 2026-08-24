# 13 — Arquitetura FlutterFlow

## Resumo

Arquitetura do novo ClipBear usando FlutterFlow como UI builder e Flutter/Dart para lógica customizada.

## Por que FlutterFlow

| Vantagem | Descrição |
|----------|-----------|
| Cross-platform | iOS + Android com um codebase |
| UI rápida | Telas visuais sem código |
| Custom Actions | Lógica complexa em Dart quando necessário |
| Export | Código Flutter real, versionável no Git |
| Iteração | Mudanças visuais sem recompilar tudo |

## O que FlutterFlow faz

| Responsabilidade | Como |
|------------------|------|
| Telas/Páginas | Visual builder |
| Navegação | Router automático |
| Componentes UI | Reusable components |
| Tema/Cores | Theme settings |
| App State | Variáveis globais |
| Animações simples | Built-in |

## O que precisa de Custom Code

| Responsabilidade | Package/Ação |
|------------------|----------------|
| Persistência (Hive) | Custom Action |
| RuleEngine | Custom Action |
| UsageMonitor | Custom Action + platform channel |
| Notificações | `flutter_local_notifications` |
| Widget home screen | `home_widget` ou platform channel |
| Export/Delete JSON | Custom Action |
| Overlay in-app | Custom Widget |
| Lottie animations | `lottie` package |

## Mapa de páginas

```
/                       → Splash (verifica onboarding)
/onboarding/welcome     → OnboardingWelcome
/onboarding/privacy     → OnboardingPrivacy
/onboarding/permissions → OnboardingPermissions
/onboarding/consent     → OnboardingConsent
/main                   → MainPage (avatar + sugestões + demos)
/settings               → SettingsPage
/demo                   → DemoSelection
/demo/confirm           → DemoConfirmation
/demo/result            → DemoResult
```

## Componentes reutilizáveis

| Componente | Usado em |
|------------|----------|
| `TinkerAvatar` | Main, Onboarding |
| `SuggestionCard` | Main, Notification |
| `LanguageToggle` | Onboarding, Settings |
| `IntensityPicker` | Settings |
| `SnoozeButton` | Settings, QuickMenu |
| `DataManagementPanel` | Settings |
| `ExplainabilityBadge` | SuggestionCard |

## App State (variáveis globais)

| Variável | Tipo | Persistida |
|----------|------|------------|
| `currentLanguage` | String | sim |
| `hasCompletedOnboarding` | bool | sim |
| `overlayEnabled` | bool | sim |
| `currentSuggestion` | Suggestion? | não |
| `tinkerState` | String | não |
| `dailySuggestionCount` | int | sim |
| `isSnoozed` | bool | sim |
| `intensity` | String | sim |

## Estrutura de diretórios (export FlutterFlow)

```
clipbear/
├── lib/
│   ├── main.dart
│   ├── app_state.dart
│   ├── flutter_flow/          # Gerado pelo FlutterFlow
│   ├── pages/                 # Páginas geradas
│   ├── components/            # Componentes gerados
│   └── custom_code/           # Código manual
│       ├── actions/
│       │   ├── rule_engine.dart
│       │   ├── export_data.dart
│       │   ├── delete_all_data.dart
│       │   └── schedule_notification.dart
│       └── widgets/
│           └── overlay_bubble.dart
├── assets/
│   ├── animations/            # Lottie files
│   ├── images/
│   └── data/
│       ├── phrases.json
│       └── strings/
├── pubspec.yaml
└── README.md
```

## Packages necessários

```yaml
dependencies:
  flutter:
    sdk: flutter
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  flutter_local_notifications: ^17.0.0
  lottie: ^3.0.0
  share_plus: ^7.0.0
  home_widget: ^0.6.0
  uuid: ^4.0.0
```

## Fluxo de desenvolvimento

1. **FlutterFlow**: Criar projeto, configurar tema, páginas, componentes
2. **Custom Actions**: Implementar lógica em `custom_code/actions/`
3. **Export**: Push to GitHub (este repositório)
4. **Custom Code**: Adicionar/editar em `lib/custom_code/`
5. **Test**: `flutter test` + testes em dispositivo
6. **Deploy**: FlutterFlow deploy ou manual build

## Limitações do FlutterFlow

| Limitação | Workaround |
|-----------|------------|
| Widget nativo | Custom code + platform channel |
| Overlay de sistema | In-app overlay (MVP) |
| UsageStats (Android) | Custom action com permissão |
| Screen Time (iOS) | Notificações como canal principal |
| Background processing | `workmanager` package |

## Setup no FlutterFlow

1. Criar projeto: **ClipBear MVP**
2. Conectar GitHub: `MagnaSoluto/ClipBear` (branch `main`)
3. Configurar idiomas: EN + PT
4. Importar tema: cores do Tinker (marrom/dourado)
5. Criar páginas conforme mapa acima
6. Adicionar Custom Actions conforme specs

## Critérios de aceite

- [ ] Projeto FlutterFlow criado e conectado ao Git
- [ ] Todas as páginas do mapa existem
- [ ] Componentes reutilizáveis criados
- [ ] App State configurado
- [ ] Custom Actions para lógica complexa
- [ ] Export gera projeto Flutter compilável
