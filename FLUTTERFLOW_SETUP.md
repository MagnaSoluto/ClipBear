# Setup FlutterFlow — ClipBear MVP

## 1. Criar projeto no FlutterFlow

1. Acesse [flutterflow.io](https://flutterflow.io)
2. Crie novo projeto: **ClipBear MVP**
3. Template: Blank App
4. Plataformas: iOS + Android

## 2. Conectar ao GitHub

1. FlutterFlow → Settings → Integrations → GitHub
2. Conecte o repositório: `MagnaSoluto/ClipBear`
3. Branch: `main`
4. Modo: **Push/Pull** (bidirecional)

## 3. Configurar projeto

### Tema

| Item | Valor |
|------|-------|
| Primary Color | `#8B6914` (marrom/dourado Tinker) |
| Secondary | `#D4A843` |
| Background | `#FFF8E7` |
| Font | Nunito ou similar arredondado |

### Idiomas

1. Project Settings → Languages
2. Adicionar: English (en), Português (pt)
3. Importar strings de `specs/strings/en.json` e `specs/strings/pt.json`

### App State

Criar variáveis conforme [specs/13-arquitetura-flutterflow.md](specs/13-arquitetura-flutterflow.md):

| Variável | Tipo | Persistida |
|----------|------|------------|
| currentLanguage | String | sim |
| hasCompletedOnboarding | bool | sim |
| overlayEnabled | bool | sim |
| intensity | String | sim |
| dailySuggestionCount | int | sim |
| snoozeUntil | DateTime | sim |
| tinkerState | String | não |

## 4. Criar páginas

Seguir mapa em [specs/13-arquitetura-flutterflow.md](specs/13-arquitetura-flutterflow.md):

| Página | Prioridade |
|--------|------------|
| OnboardingWelcome | P0 |
| OnboardingPrivacy | P0 |
| OnboardingPermissions | P0 |
| OnboardingConsent | P0 |
| MainPage | P0 |
| SettingsPage | P0 |
| DemoSelection | P1 |
| DemoConfirmation | P1 |
| DemoResult | P1 |

## 5. Criar componentes

| Componente | Spec |
|------------|------|
| TinkerAvatar | [01-overlay-bubble.md](specs/01-overlay-bubble.md) |
| SuggestionCard | [03-regras-comportamentais.md](specs/03-regras-comportamentais.md) |
| LanguageToggle | [10-localizacao.md](specs/10-localizacao.md) |
| IntensityPicker | [06-configuracoes.md](specs/06-configuracoes.md) |
| ExplainabilityBadge | [03-regras-comportamentais.md](specs/03-regras-comportamentais.md) |

## 6. Custom Actions

Registrar no FlutterFlow → Custom Code → Actions:

| Action | Arquivo | Spec |
|--------|---------|------|
| evaluateRules | `lib/custom_code/actions/rule_engine.dart` | [03](specs/03-regras-comportamentais.md) |
| exportAllData | `lib/custom_code/actions/export_data.dart` | [09](specs/09-dados-persistencia.md) |
| deleteAllData | `lib/custom_code/actions/delete_all_data.dart` | [09](specs/09-dados-persistencia.md) |
| scheduleNotification | `lib/custom_code/actions/schedule_notification.dart` | [07](specs/07-notificacoes.md) |

## 7. Packages

Adicionar em FlutterFlow → Settings → Dependencies:

```
hive: ^2.2.3
hive_flutter: ^1.1.0
flutter_local_notifications: ^17.2.4
lottie: ^3.1.2
share_plus: ^10.0.0
home_widget: ^0.6.0
uuid: ^4.5.1
```

## 8. Export e deploy

1. FlutterFlow → Deploy → Push to GitHub
2. Localmente: `flutter pub get && flutter run`
3. TestFlight/Play Store: FlutterFlow Deploy ou build manual

## Ordem de implementação sugerida

```
Fase 1: Onboarding + Main + Settings (UI)
Fase 2: Persistência Hive + App State
Fase 3: RuleEngine + Notificações
Fase 4: Demos + Widget
Fase 5: Overlay in-app + Lottie
Fase 6: Beta
```

## Referência completa

Todas as specs em [specs/README.md](specs/README.md).
