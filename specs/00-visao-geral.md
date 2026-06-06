# 00 — Visão Geral

## O que é o ClipBear

Assistente companheiro **privacy-first** com estilo nostálgico de popup/bubble (como o Clippy). O avatar **Tinker** observa padrões de uso do celular e oferece sugestões simples com explicabilidade.

## Objetivo do MVP

**Não é sobre ser "inteligente".** É um teste fail-fast para validar:

1. Usuários gostam de um companheiro flutuante que observa comportamentos?
2. Usuários se engajam com sugestões simples?
3. Usuários aceitam o modelo de privacidade (dados 100% locais)?

## Princípios

| Princípio | Descrição |
|-----------|-----------|
| Privacy-first | Dados nunca saem do dispositivo |
| Opt-in | Overlay desligado por padrão |
| Fail-fast | Regras mínimas, sem LLM |
| Explicabilidade | Toda sugestão mostra "Por quê?" |
| Multilíngue | Inglês + Português desde o dia 1 |
| Cross-platform | iOS e Android via Flutter/FlutterFlow |

## Escopo do MVP

### Incluído

- Avatar Tinker com estados visuais (idle, suggest, speak)
- Onboarding de 4 etapas com consentimento
- 3 regras comportamentais simples (A/B/C)
- Frases pré-definidas (sem LLM)
- Demos falsas de integração (comida, mesa)
- Configurações (intensidade, snooze, export/delete)
- Notificações locais com ações
- Widget de home screen
- Localização EN/PT

### Fora do escopo (v2+)

- LLM / IA generativa
- Integrações reais (iFood, OpenTable, etc.)
- Overlay de sistema (fora do app) — limitação de plataforma
- Analytics em nuvem
- Sincronização entre dispositivos

## Plataformas

| Plataforma | Versão mínima | Notas |
|------------|---------------|-------|
| iOS | 14.0+ | Widget via WidgetKit (custom code) |
| Android | 8.0+ (API 26) | Widget via App Widget (custom code) |

## Identificadores

| Item | Valor |
|------|-------|
| Bundle ID | `com.clipbear.mvp` |
| URL Scheme | `clipbear://open` |
| App Group (iOS) | `group.com.clipbear.mvp` |

## Stack (novo)

| Camada | Tecnologia |
|--------|------------|
| UI Builder | FlutterFlow |
| Framework | Flutter 3.x |
| Linguagem | Dart |
| Persistência | Hive ou SQLite (via custom action) |
| Animações avatar | Lottie (via FlutterFlow) |
| Notificações | flutter_local_notifications |
| Widget | Custom code (platform channels) |

## Métricas de sucesso do beta

| Métrica | Threshold |
|---------|-----------|
| Taxa de aceitação | ≥ 15% |
| Engajamento conversacional | ≥ 1 interação/dia |
| Retenção D7 | ≥ 25% |
| Satisfação com privacidade | ≥ 80% |
