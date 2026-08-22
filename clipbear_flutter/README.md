# 🐻 ClipBear Flutter - Digital Companion Assistant

**Version**: 2.0.0  
**Platform**: Flutter (iOS, Android, Web)  
**Status**: 🚧 Em Desenvolvimento Ativo

---

## 📱 O Que é ClipBear?

ClipBear é um assistente companheiro digital com foco em privacidade que observa seus hábitos e oferece sugestões úteis para melhorar sua experiência. Agora completamente reimaginado em **Flutter** com UX moderna!

**Personagem**: Tinker 🤖 - Seu amigo robô animado e expressivo

---

## ✨ O Que Há de Novo no v2.0 (Flutter)

### 🎨 UX Completamente Redesenhada
- ✅ **Material Design 3** com tema personalizado
- ✅ **Avatar Animado** com múltiplas expressões
- ✅ **Animações Fluidas** em todas as interações
- ✅ **Tema Dark/Light** com transições suaves
- ✅ **Glassmorphism** e efeitos modernos
- ✅ **Micro-interações** deliciosas

### 🚀 Cross-Platform
- ✅ **iOS** - Substituindo versão Swift/SwiftUI
- ✅ **Android** - Nova plataforma
- ✅ **Web** - Nova plataforma

### 🏗️ Arquitetura Moderna
- ✅ **Clean Architecture** com separação clara de responsabilidades
- ✅ **GetX** para state management
- ✅ **Design System** completo e consistente
- ✅ **Código organizado** e escalável

---

## 🎯 Features Planejadas

### Core Features (MVP)
- [ ] 🌐 Sistema de localização PT/EN dinâmico
- [ ] 👋 Onboarding moderno com animações
- [ ] 🤖 Avatar Tinker animado (Lottie/Rive)
- [ ] 💡 Sistema de sugestões inteligentes
- [ ] 🔔 Notificações locais acionáveis
- [ ] ⚙️ Configurações com preview ao vivo
- [ ] 💾 Persistência local (Hive + SQLite)
- [ ] 📊 Histórico e insights visuais

### Features Avançadas (v2.1+)
- [ ] 🎨 Personalização de avatar
- [ ] 🏆 Sistema de conquistas
- [ ] 📈 Gráficos de atividade
- [ ] 🌙 Modo de horário silencioso
- [ ] 🔒 Export/Import de dados
- [ ] 🎭 Múltiplos avatares desbloqueáveis

---

## 🛠️ Stack Técnico

### Frameworks & Libraries
```yaml
Core:
- Flutter 3.47.1+
- Dart 3.13.1+
- Material Design 3

State Management:
- GetX 4.6.6

Storage:
- Hive 2.2.3 (NoSQL local)
- SQLite 2.3.2 (SQL local)
- Shared Preferences 2.2.3

Animations:
- Lottie 3.1.2
- Rive 0.13.9
- Animator 3.2.2

UI Components:
- Google Fonts 6.2.1
- Flutter SVG 2.0.10
- Shimmer 3.0.0
- Glassmorphism 3.0.0
- Confetti 0.7.0

Notificações:
- Flutter Local Notifications 17.2.3

Utilidades:
- Permission Handler 11.3.1
- Intl 0.20.0 (i18n)
- Timeago 3.7.0
- Vibration 2.0.0

Charts:
- FL Chart 0.69.2
```

---

## 📂 Estrutura do Projeto

```
clipbear_flutter/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart           ✅ Completo
│   │   │   ├── app_dimensions.dart       ✅ Completo
│   │   │   └── app_text_styles.dart      ✅ Completo
│   │   ├── theme/
│   │   │   └── app_theme.dart            ✅ Completo
│   │   ├── localization/
│   │   │   └── l10n/                     🚧 Em breve
│   │   ├── utils/                        🚧 Em breve
│   │   └── widgets/                      🚧 Em breve
│   │
│   ├── features/
│   │   ├── onboarding/                   🚧 Em breve
│   │   ├── home/
│   │   │   └── presentation/
│   │   │       └── pages/
│   │   │           └── home_page.dart    ✅ Completo
│   │   ├── settings/                     🚧 Em breve
│   │   └── history/                      🚧 Em breve
│   │
│   ├── services/                         🚧 Em breve
│   └── main.dart                         ✅ Completo
│
├── assets/
│   ├── animations/                       🚧 Em breve
│   ├── images/                           🚧 Em breve
│   └── fonts/                            🚧 Em breve
│
├── pubspec.yaml                          ✅ Completo
└── README.md                             ✅ Você está aqui!
```

---

## 🚀 Como Rodar

### Requisitos
- Flutter 3.13.1+
- Dart 3.13.1+
- Android Studio / VS Code / Xcode

### Passos

1. **Clone o Repositório**
```bash
git clone https://github.com/MagnaSoluto/ClipBear.git
cd ClipBear/clipbear_flutter
```

2. **Instale Dependências**
```bash
flutter pub get
```

3. **Execute**
```bash
# Web
flutter run -d chrome

# iOS (macOS apenas)
flutter run -d ios

# Android
flutter run -d android
```

4. **Build para Produção**
```bash
# Android APK
flutter build apk --release

# iOS (macOS apenas)
flutter build ios --release

# Web
flutter build web --release
```

---

## 🎨 Design System

### Cores Principais
```dart
Primary:     #6C63FF  (Roxo vibrante)
Secondary:   #4CAF50  (Verde sucesso)
Accent:      #FF6B6B  (Vermelho atenção)
Background:  #F8F9FA  (Cinza claro)
Surface:     #FFFFFF  (Branco)
```

### Typography
```dart
Família: Inter
Display: 32px / Bold / -0.5 letter-spacing
Headline: 24px / SemiBold
Body: 16px / Normal / 1.5 line-height
Label: 14px / Medium / 0.1 letter-spacing
```

### Espaçamento (8pt grid)
```dart
space1: 4px   (0.5x)
space2: 8px   (1x)
space3: 16px  (2x)
space4: 24px  (3x)
space5: 32px  (4x)
space6: 48px  (6x)
space7: 64px  (8x)
```

### Border Radius
```dart
Small:  8px
Medium: 16px
Large:  24px
XLarge: 32px
Circle: 999px
```

---

## 🔒 Privacidade

ClipBear v2.0 mantém o mesmo compromisso com privacidade:

- ✅ **Dados locais** - Nunca enviados para servidores
- ✅ **Sem tracking** - Zero analytics de terceiros
- ✅ **Consent explícito** - Usuário no controle
- ✅ **Export/Delete** - Transparência total
- ✅ **Open Source** - Código auditável

---

## 🧪 Testes

```bash
# Rodar todos os testes
flutter test

# Testes com coverage
flutter test --coverage

# Análise de código
flutter analyze
```

---

## 📖 Documentação Adicional

- 📄 **[FLUTTER_UX_MODERNIZATION.md](../FLUTTER_UX_MODERNIZATION.md)** - Análise UX detalhada e roadmap
- 📄 **[iOS Original README](../ios/ClipBear/README.md)** - Versão iOS nativa (Swift)
- 📄 **[EXECUTIVE_SUMMARY.md](../EXECUTIVE_SUMMARY.md)** - Resumo executivo do projeto
- 📄 **[PRIVACY.md](../PRIVACY.md)** - Política de privacidade

---

## 🚦 Status de Desenvolvimento

### ✅ Completo (v2.0 - Fase 1)
- [x] Estrutura Clean Architecture
- [x] Design System completo
- [x] Tema Light/Dark
- [x] HomePage inicial
- [x] Configuração de dependências
- [x] Análise de código sem erros

### 🚧 Em Progresso (v2.0 - Fase 2)
- [ ] Sistema de localização (i18n)
- [ ] Onboarding moderno
- [ ] Avatar Tinker animado
- [ ] Sistema de sugestões
- [ ] Notificações
- [ ] Configurações
- [ ] Persistência de dados

### 🔮 Futuro (v2.1+)
- [ ] Gamification
- [ ] Histórico visual
- [ ] Personalização avançada
- [ ] Integrações externas
- [ ] Modo widget

---

## 📊 Comparação: iOS Nativo vs Flutter

| Aspecto | iOS (Swift) | Flutter |
|---------|-------------|---------|
| **Plataformas** | iOS apenas | iOS + Android + Web |
| **Desenvolvimento** | Xcode, macOS | Qualquer SO |
| **Hot Reload** | Limitado | ⚡ Instantâneo |
| **UI Framework** | SwiftUI | Flutter Widgets |
| **Animações** | Limitado | 🎨 Extensivo |
| **Manutenção** | Por plataforma | Codebase único |
| **Performance** | Nativo | Near-native |

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Por favor:

1. Fork o repositório
2. Crie uma branch (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -m 'feat: adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

### Convenção de Commits
```
feat: nova funcionalidade
fix: correção de bug
docs: documentação
style: formatação
refactor: refatoração
test: testes
chore: tarefas gerais
```

---

## 📄 Licença

MIT License - Veja [LICENSE](../LICENSE) para detalhes

---

## 👥 Equipe

- **Projeto Original**: ClipBear iOS (Swift/SwiftUI)
- **Modernização Flutter**: v2.0 - Agosto 2026
- **Arquitetura**: Clean Architecture + GetX
- **Design**: Material Design 3 + Custom Design System

---

## 📞 Suporte

Para questões, bugs ou sugestões:
- 🐛 Abra uma [Issue](https://github.com/MagnaSoluto/ClipBear/issues)
- 💬 Discussões no [GitHub Discussions](https://github.com/MagnaSoluto/ClipBear/discussions)

---

**🚀 ClipBear v2.0 - Seu companheiro digital reimaginado! 🐻**

*Última atualização: 22 de Agosto, 2026*  
*Status: Em Desenvolvimento Ativo*  
*Análise: ✅ Sem erros*
