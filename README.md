# ClipBear MVP

Assistente companheiro **privacy-first** com estilo nostálgico de popup/bubble. O avatar **Tinker** observa padrões de uso e oferece sugestões simples com explicabilidade.

## Status

**Reinício do projeto** — migrando de Swift/iOS nativo para **FlutterFlow + Flutter** (iOS + Android).

O código Swift anterior foi removido. As specs de produto foram preservadas e reorganizadas.

## Quick Start

1. Leia as [especificações](specs/README.md)
2. Siga o [setup FlutterFlow](FLUTTERFLOW_SETUP.md)
3. Implemente página por página conforme as specs

## Stack

| Camada | Tecnologia |
|--------|------------|
| UI Builder | FlutterFlow |
| Framework | Flutter 3.x |
| Linguagem | Dart |
| Persistência | Hive (encrypted) |
| Animações | Lottie |
| Plataformas | iOS 14+ / Android 8+ |

## Estrutura

```
clipbear/
├── specs/                  # Especificações de cada funcionalidade
│   ├── README.md           # Índice das specs
│   ├── 00-visao-geral.md
│   ├── 01-overlay-bubble.md
│   ├── ...
│   └── strings/            # Localização EN/PT
├── lib/
│   ├── main.dart           # Entry point (placeholder)
│   ├── app_state.dart      # Estado global
│   └── custom_code/        # Lógica customizada (RuleEngine, etc.)
├── assets/
│   ├── animations/         # Lottie do Tinker
│   ├── images/
│   └── data/               # phrases.json
├── FLUTTERFLOW_SETUP.md    # Guia de setup no FlutterFlow
├── BETA_PLAN.md            # Plano de teste beta
└── PRIVACY.md              # Política de privacidade
```

## Funcionalidades (MVP)

| # | Feature | Spec |
|---|---------|------|
| 1 | Overlay Bubble (Tinker) | [spec](specs/01-overlay-bubble.md) |
| 2 | Onboarding & Consentimento | [spec](specs/02-onboarding-consentimento.md) |
| 3 | Regras Comportamentais A/B/C | [spec](specs/03-regras-comportamentais.md) |
| 4 | Conversa Stub (EN/PT) | [spec](specs/04-conversa-stub.md) |
| 5 | Demo de Integração Falsa | [spec](specs/05-demo-integracao.md) |
| 6 | Configurações | [spec](specs/06-configuracoes.md) |
| 7 | Notificações | [spec](specs/07-notificacoes.md) |
| 8 | Widget Home Screen | [spec](specs/08-widget.md) |

## Princípios

- **Privacy-first** — dados 100% locais, nunca em servidores
- **Opt-in** — overlay desligado por padrão
- **Fail-fast** — regras mínimas, sem LLM no MVP
- **Explicabilidade** — toda sugestão mostra "Por quê?"
- **Cross-platform** — iOS + Android desde o dia 1

## Lições do projeto anterior

O MVP iOS (Swift/SwiftUI) tinha infraestrutura parcial mas não entregava o núcleo:

- Overlay flutuante não implementado
- Motor de regras ausente
- Pipeline de sugestões desconectado
- Documentação superestimava o estado real

Este reinício corrige com **specs primeiro** e **FlutterFlow** para UI cross-platform.

## Licença

MIT — veja [LICENSE](LICENSE)
