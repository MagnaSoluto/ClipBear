# 🐻 ClipBear MVP - Companion Overlay

[![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org/)
[![TestFlight](https://img.shields.io/badge/TestFlight-Ready-brightgreen.svg)](https://developer.apple.com/testflight/)
[![Build](https://img.shields.io/badge/Build-Passing-success.svg)](https://github.com/MagnaSoluto/ClipBear)
[![Tests](https://img.shields.io/badge/Tests-30%2B%20Passing-success.svg)](https://github.com/MagnaSoluto/ClipBear)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Privacy-First Companion Assistant

ClipBear is a privacy-first companion assistant with a nostalgic popup/bubble style (like Clippy). This MVP focuses on testing user engagement with a floating companion that notices behaviors and interacts through simple suggestions.

---

## 🚀 **Quick Start**

### **For Immediate Deploy**:
📖 Read **[NEXT_STEPS.md](NEXT_STEPS.md)** - Get to TestFlight in 50 minutes!

### **For Complete Overview**:
📖 Read **[EXECUTIVE_SUMMARY.md](EXECUTIVE_SUMMARY.md)** - Full project summary

### **For Testing**:
📖 Read **[ios/ClipBear/TESTFLIGHT_READY.md](ios/ClipBear/TESTFLIGHT_READY.md)** - Complete QA checklist

### **For Setup**:
📖 Read **[ios/ClipBear/APP_GROUP_SETUP.md](ios/ClipBear/APP_GROUP_SETUP.md)** - App Group configuration

---

## 🎯 MVP Goals

- **NOT about being "smart" yet**
- Test if users enjoy a floating companion that notices behaviors
- Test if they engage with simple suggestions or conversations
- Fail-fast design with minimal rules and stub conversations
- Multilingual support (English + Portuguese)

## 🚀 Core Features

### 1. Overlay Bubble (Opt-in)
- Floating avatar "Tinker"
- Draggable, dockable in screen corners
- Tap: small dock window with latest suggestion
- Long press: settings menu
- Avatar states: idle, suggest, speak
- Overlay only enabled if user opts in

### 2. Onboarding & Consent
- Language detection (EN/PT) + manual switch
- Clear privacy explanation
- Permissions requested with rationale
- Consent timestamp stored

### 3. Behavioral Rules (Simple)
- **Rule A**: Screen restlessness detection
- **Rule B**: WhatsApp focus detection  
- **Rule C**: Evening leisure detection
- Always show explainability

### 4. Conversation Stub
- Predefined short phrases (EN/PT)
- Reflective, humorous, practical suggestions
- No LLM in MVP; fallback to stub always

### 5. Fake Integration Demo
- "Shall I order food?" or "Shall I book a table?"
- Fake confirmation flows (no real API calls)
- Validates if users like "companion that acts"

## 🔒 Privacy & Security

- **Data stays local** - never sent to servers
- **Encrypted storage** - all data encrypted locally
- **Deletable/Exportable** - full control over your data
- **Opt-in only** - overlay disabled by default
- **No message reading** - only detects app usage patterns
- **No network in release** - release builds make no network calls by default
- **External integrations require opt-in** - any external integration uses official APIs with explicit user consent

## 🛡️ Safety & Controls

### Suggestion Limits
- **Basic mode**: 1-2 suggestions per day
- **Proactive mode**: Up to 5 suggestions per day (hard cap)
- **Global limit**: The assistant will never show more than 5 suggestions per day

### Quick Controls
- **Snooze options**: 1h / 24h / permanent available on long-press
- **Diagnostics**: Opt-in only, encrypted, local; off by default
- **Data control**: "Delete all data" and "Export JSON" always available in Settings

### Accessibility
- **TalkBack/VoiceOver** support for screen readers
- **Dynamic Type** support for font scaling
- **High contrast** support (WCAG 2.1 AA compliance)
- **Focus navigation** validated for keyboard/switch control

### Permissions & Rationale
- **UsageStats permission**: Shown with rationale screen before system dialog
- **Overlay permission**: Opt-in only with clear declaration and rationale
- **Fallback behavior**: If permissions denied, app continues with available signals and disables overlay features

### Explainability
- **Every suggestion shows "Why?"**: "Because you opened WhatsApp 3 times in 30 minutes"
- **Transparent reasoning**: Users always understand why suggestions appear

## 🛠️ Technical Stack

- **Android**: Kotlin + Jetpack Compose
- **iOS**: Swift + SwiftUI
- **Storage**: Room + SQLCipher (Android) / CoreData encrypted (iOS)
- **Overlay**: System Alert Window (Android) / Overlay Window (iOS)
- **Animations**: Lottie for avatar states

## 📱 Platform Support

- Android 8.0+ (API 26+)
- iOS 14.0+
- Multilingual: English + Portuguese

## 🚦 Development Status

- [x] Project scaffold
- [ ] Overlay bubble implementation
- [ ] Onboarding & consent
- [ ] Encrypted storage
- [ ] Behavioral rules engine
- [ ] Conversation stub
- [ ] Fake integration demos
- [ ] Settings & controls
- [ ] Feedback & metrics
- [ ] Beta testing

## 🧪 Beta Plan

- **Duration**: 2 weeks
- **Users**: 30-50
- **Success Metrics**:
  - Acceptance Rate ≥ 15%
  - Conversational Engagement ≥ 1 interaction/day
  - D7 Retention ≥ 25%

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

This is an MVP project. Contributions are welcome but please ensure they align with the privacy-first, fail-fast approach.

---

# ClipBear MVP - Assistente Companheiro

## Assistente Companheiro com Foco em Privacidade

ClipBear é um assistente companheiro com foco em privacidade com estilo de popup/bubble nostálgico (como o Clippy). Este MVP foca em testar o engajamento do usuário com um companheiro flutuante que observa comportamentos e interage através de sugestões simples.

## 🎯 Objetivos do MVP

- **NÃO é sobre ser "inteligente" ainda**
- Testar se usuários gostam de um companheiro flutuante que observa comportamentos
- Testar se eles se engajam com sugestões ou conversas simples
- Design fail-fast com regras mínimas e conversas simuladas
- Suporte multilíngue (Inglês + Português)

## 🚀 Funcionalidades Principais

### 1. Bolha de Overlay (Opt-in)
- Avatar flutuante "Tinker"
- Arrastável, encaixável nos cantos da tela
- Toque: janela pequena com última sugestão
- Pressionar longo: menu de configurações
- Estados do avatar: idle, suggest, speak
- Overlay habilitado apenas se usuário optar

### 2. Onboarding & Consentimento
- Detecção de idioma (EN/PT) + troca manual
- Explicação clara de privacidade
- Permissões solicitadas com justificativa
- Timestamp de consentimento armazenado

### 3. Regras Comportamentais (Simples)
- **Regra A**: Detecção de inquietação na tela
- **Regra B**: Detecção de foco no WhatsApp
- **Regra C**: Detecção de lazer noturno
- Sempre mostrar explicabilidade

### 4. Conversa Simulada
- Frases pré-definidas (EN/PT)
- Sugestões reflexivas, humorísticas, práticas
- Sem LLM no MVP; sempre fallback para simulada

### 5. Demo de Integração Falsa
- "Quer que eu peça comida?" ou "Quer que eu reserve uma mesa?"
- Fluxos de confirmação falsos (sem chamadas reais de API)
- Valida se usuários gostam de "companheiro que age"

## 🔒 Privacidade & Segurança

- **Dados ficam locais** - nunca enviados para servidores
- **Armazenamento criptografado** - todos os dados criptografados localmente
- **Deletável/Exportável** - controle total sobre seus dados
- **Opt-in apenas** - overlay desabilitado por padrão
- **Sem leitura de mensagens** - apenas detecta padrões de uso de apps
- **Sem rede em release** - builds de release não fazem chamadas de rede por padrão
- **Integrações externas exigem opt-in** - qualquer integração externa usa APIs oficiais com consentimento explícito do usuário

## 🛡️ Segurança & Controles

### Limites de Sugestões
- **Modo básico**: 1-2 sugestões por dia
- **Modo proativo**: Até 5 sugestões por dia (limite rígido)
- **Limite global**: O assistente nunca exibirá mais de 5 sugestões por dia

### Controles Rápidos
- **Opções de soneca**: 1h / 24h / permanente disponível no toque longo
- **Diagnóstico**: Somente opt-in, criptografado, local; desligado por padrão
- **Controle de dados**: "Apagar tudo" e "Exportar JSON" sempre disponíveis em Configurações

### Acessibilidade
- **Suporte TalkBack/VoiceOver** para leitores de tela
- **Suporte Dynamic Type** para escalonamento de fonte
- **Suporte alto contraste** (conformidade WCAG 2.1 AA)
- **Navegação por foco** validada para controle por teclado/switch

### Permissões & Justificativa
- **Permissão UsageStats**: Mostrada com tela de justificativa antes do diálogo do sistema
- **Permissão Overlay**: Apenas opt-in com declaração clara e justificativa
- **Comportamento de fallback**: Se permissões negadas, app continua com sinais disponíveis e desativa recursos de overlay

### Explicabilidade
- **Cada sugestão mostra "Por quê?"**: "Porque você abriu o WhatsApp 3 vezes em 30 minutos"
- **Raciocínio transparente**: Usuários sempre entendem por que sugestões aparecem

## 🛠️ Stack Técnico

- **Android**: Kotlin + Jetpack Compose
- **iOS**: Swift + SwiftUI
- **Armazenamento**: Room + SQLCipher (Android) / CoreData criptografado (iOS)
- **Overlay**: System Alert Window (Android) / Overlay Window (iOS)
- **Animações**: Lottie para estados do avatar

## 📱 Suporte de Plataforma

- Android 8.0+ (API 26+)
- iOS 14.0+
- Multilíngue: Inglês + Português

## 🚦 Status de Desenvolvimento

### **iOS** ✅ **100% COMPLETO - TESTFLIGHT READY**
- [x] Scaffold do projeto
- [x] Onboarding & consentimento (4 steps)
- [x] Armazenamento criptografado (Core Data)
- [x] Localização dinâmica (EN/PT)
- [x] Notificações com ações
- [x] Widget para home screen
- [x] Demos de integração (food/table)
- [x] Configurações & controles
- [x] Export/Delete dados
- [x] Accessibility (VoiceOver)
- [x] 30+ Unit Tests
- [x] Pronto para TestFlight

📖 **Ver**: `ios/ClipBear/README.md` e `ios/ClipBear/TESTFLIGHT_READY.md`

### **Android** ⚠️ **REMOVIDO**
- Pasta android/ removida temporariamente
- Foco 100% em iOS para MVP
- Android será v2

## 🧪 Plano Beta

- **Duração**: 2 semanas
- **Usuários**: 30-50
- **Métricas de Sucesso**:
  - Taxa de Aceitação ≥ 15%
  - Engajamento Conversacional ≥ 1 interação/dia
  - Retenção D7 ≥ 25%

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 🤝 Contribuindo

Este é um projeto MVP. Contribuições são bem-vindas, mas por favor garanta que estejam alinhadas com a abordagem privacy-first e fail-fast.

