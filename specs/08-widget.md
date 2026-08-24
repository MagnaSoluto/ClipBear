# 08 — Widget de Home Screen

## Resumo

Widget que exibe a última sugestão do Tinker na home screen. Tap abre o app via deep link.

## Layout do widget

### Tamanho pequeno (2x2)

```
┌──────────────┐
│ 🐻 ClipBear  │
│ "Que tal uma │
│  pausa?"     │
└──────────────┘
```

### Tamanho médio (4x2)

```
┌────────────────────────────┐
│ 🐻 Tinker diz:             │
│ "Que tal uma pausa?"       │
│ Há 5 minutos               │
└────────────────────────────┘
```

## Dados compartilhados

| Campo | Tipo | Origem |
|-------|------|--------|
| `latestSuggestionMessage` | String | Última sugestão |
| `latestSuggestionTimestamp` | DateTime | Timestamp |
| `tinkerState` | String | idle/suggest/speak |

### iOS: App Group

- ID: `group.com.clipbear.mvp`
- Storage: `UserDefaults(suiteName:)`

### Android: SharedPreferences

- File: `clipbear_widget_prefs`
- Mode: `MODE_PRIVATE` com backup

## Deep link

| Plataforma | URL |
|------------|-----|
| iOS/Android | `clipbear://open` |

Tap no widget → abre app na tela principal.

## Custom Actions

| Action | Descrição |
|--------|-----------|
| `publishToWidget(message, timestamp)` | Atualiza dados do widget |
| `clearWidget()` | Limpa widget (ex: após delete all data) |
| `reloadWidget()` | Força refresh do widget |

## Implementação

Widget requer **custom code** (não suportado nativamente pelo FlutterFlow):

- **iOS**: WidgetKit extension via platform channel
- **Android**: App Widget via platform channel
- **Flutter**: Package `home_widget` como alternativa

## Critérios de aceite

- [ ] Widget exibe última sugestão
- [ ] Atualiza quando nova sugestão é criada
- [ ] Tap abre app via deep link
- [ ] Limpa ao deletar todos os dados
- [ ] Funciona em iOS e Android
- [ ] Acessibilidade: label descritivo
