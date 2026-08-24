# 01 — Overlay Bubble (Companheiro Flutuante)

## Resumo

Avatar **Tinker** que aparece como companheiro flutuante **dentro do app** (in-app overlay). Overlay de sistema (sobre outros apps) é limitação de plataforma e fica para v2.

## Avatar Tinker

### Estados visuais

| Estado | Descrição | Animação |
|--------|-----------|----------|
| `idle` | Repouso, aguardando | Respiração suave, olhos piscando |
| `suggest` | Tem uma sugestão | Orelhas levantadas, expressão curiosa |
| `speak` | Falando/mostrando sugestão | Boca animada, balão de fala |

### Implementação FlutterFlow

- **Component**: `TinkerAvatar` (reusable component)
- **Animação**: Lottie files para cada estado
- **Assets**: `assets/animations/tinker_idle.json`, `tinker_suggest.json`, `tinker_speak.json`

## Interações

| Ação | Comportamento |
|------|---------------|
| **Toque** | Abre painel com última sugestão + botões aceitar/rejeitar |
| **Arrastar** | Move avatar pela tela |
| **Soltar perto de canto** | Encaixa (dock) no canto mais próximo |
| **Toque longo** | Menu rápido: snooze 1h, snooze 24h, configurações |

## Posicionamento

- Posição padrão: canto inferior direito
- Cantos disponíveis: top-left, top-right, bottom-left, bottom-right
- Persistir posição escolhida em `AppSettings.overlayPosition`
- Margem de segurança: 16dp das bordas

## Opt-in

- **Desligado por padrão** (`overlayEnabled = false`)
- Toggle na tela principal e nas configurações
- Sem overlay até usuário ativar explicitamente
- Se permissões negadas, overlay permanece desabilitado com mensagem explicativa

## Painel de sugestão (ao tocar)

```
┌─────────────────────────────┐
│  🐻 Tinker diz:             │
│  "Quer dar uma pausa?"      │
│                             │
│  Por quê?                   │
│  "Você ligou a tela 8x      │
│   em 15 minutos"            │
│                             │
│  [👍 Aceitar]  [👎 Rejeitar]│
└─────────────────────────────┘
```

## Menu de toque longo

```
┌─────────────────────┐
│  ⏸️ Soneca 1 hora   │
│  ⏸️ Soneca 24 horas │
│  ⚙️ Configurações   │
└─────────────────────┘
```

## Custom Actions necessárias

| Action | Descrição |
|--------|-----------|
| `showOverlayBubble` | Exibe overlay in-app |
| `hideOverlayBubble` | Esconde overlay |
| `dockAvatarToCorner` | Encaixa no canto mais próximo |
| `showSuggestionPanel` | Abre painel com sugestão atual |
| `showQuickMenu` | Menu de snooze/config |

## Limitações conhecidas

- **iOS**: Overlay sobre outros apps requer Screen Time API ou atalhos — não no MVP
- **Android**: System Alert Window possível mas complexo — avaliar em v2
- **MVP**: Companheiro funciona **dentro do app** + notificações + widget

## Critérios de aceite

- [ ] Avatar renderiza nos 3 estados com Lottie
- [ ] Arrastar e encaixar nos 4 cantos funciona
- [ ] Toque abre painel com sugestão e explicação
- [ ] Toque longo abre menu de snooze
- [ ] Overlay só aparece se `overlayEnabled = true`
- [ ] Posição persiste entre sessões
- [ ] Labels de acessibilidade em todos os controles
