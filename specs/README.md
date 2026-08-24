# ClipBear — Especificações do Produto

> Reinício do projeto com **FlutterFlow + Flutter** (iOS e Android).
> Estas specs preservam a visão de produto do MVP original, corrigindo a arquitetura.

## Índice

| # | Spec | Descrição |
|---|------|-----------|
| 00 | [Visão Geral](00-visao-geral.md) | Propósito, princípios, escopo do MVP |
| 01 | [Overlay Bubble](01-overlay-bubble.md) | Avatar Tinker flutuante, estados, interações |
| 02 | [Onboarding & Consentimento](02-onboarding-consentimento.md) | Fluxo de 4 etapas, privacidade, permissões |
| 03 | [Regras Comportamentais](03-regras-comportamentais.md) | Motor de regras A/B/C, explicabilidade |
| 04 | [Conversa Stub](04-conversa-stub.md) | Frases pré-definidas EN/PT, categorias |
| 05 | [Demo de Integração](05-demo-integracao.md) | Fluxos falsos de pedido de comida e reserva |
| 06 | [Configurações](06-configuracoes.md) | Intensidade, snooze, diagnósticos, dados |
| 07 | [Notificações](07-notificacoes.md) | Sugestões via push, ações aceitar/rejeitar |
| 08 | [Widget](08-widget.md) | Widget de home screen, deep link |
| 09 | [Dados & Persistência](09-dados-persistencia.md) | Schema, export JSON, delete |
| 10 | [Localização](10-localizacao.md) | EN/PT, chaves de strings |
| 11 | [Acessibilidade](11-acessibilidade.md) | TalkBack, Dynamic Type, WCAG |
| 12 | [Beta & Métricas](12-beta-metricas.md) | Plano beta, critérios go/pivot/kill |
| 13 | [Arquitetura FlutterFlow](13-arquitetura-flutterflow.md) | Stack, páginas, custom actions, limitações |

## Strings de localização

- [EN](strings/en.json)
- [PT](strings/pt.json)

## Lições do projeto anterior

O MVP iOS nativo (Swift/SwiftUI) tinha infraestrutura parcial mas **não entregava o núcleo do produto**:

- Overlay flutuante não implementado
- Motor de regras comportamentais ausente
- Pipeline de sugestões desconectado
- Documentação superestimava o estado real ("TestFlight-ready")

Este reinício corrige isso com:

1. **Specs primeiro** — cada feature documentada antes de implementar
2. **FlutterFlow** — UI rápida, cross-platform (iOS + Android)
3. **Custom Actions** — lógica nativa (overlay, regras) via código Flutter
4. **Arquitetura honesta** — separação clara entre o que FlutterFlow faz e o que precisa de código customizado
