# 🐻 ClipBear iOS - Digital Companion App

**Version**: 1.0 MVP  
**Status**: ✅ TestFlight Production-Ready  
**Platform**: iOS 15.0+  
**Language**: Swift 5 + SwiftUI

---

## 📱 **O Que é ClipBear?**

ClipBear é um companheiro digital inteligente que observa seus hábitos de uso do celular e oferece sugestões úteis para melhorar sua experiência.

**Personagem**: Tinker 🤖 - Seu amigo robô que te ajuda com sugestões contextuais.

---

## ✨ **Funcionalidades**

### **Core Features**:
- 🌐 **Localização**: Suporte completo para Português e Inglês
- 🔔 **Notificações Inteligentes**: Sugestões com ações (Aceitar/Rejeitar)
- 📊 **Widget**: Companheiro na tela inicial
- 🔒 **Privacidade First**: Todos os dados no dispositivo
- 💾 **Export/Delete**: Controle total dos seus dados
- ♿ **Acessibilidade**: VoiceOver e Dynamic Type

### **Telas**:
1. **Onboarding** - 4 steps: Welcome, Privacy, Permissions, Consent
2. **Main View** - Status, Latest Suggestions, Demo Actions
3. **Settings** - Language, Intensity, Snooze, Data Management

---

## 🏗️ **Arquitetura**

### **Stack Técnico**:
- **UI**: SwiftUI
- **Persistence**: Core Data
- **Architecture**: MVVM
- **Localization**: Dynamic bundle loading
- **Widget**: WidgetKit + App Group
- **Notifications**: UserNotifications framework
- **Tests**: XCTest (30+ unit tests)

### **Componentes Principais**:

```
ClipBear/
├── App/
│   ├── ClipBearApp.swift          # Main app entry
│   └── ContentView.swift          # Root view + navigation
│
├── Views/
│   ├── OnboardingView.swift       # 4-step onboarding
│   ├── MainView.swift             # Main screen
│   ├── SettingsView.swift         # Settings screen
│   ├── DemoView.swift             # Demo integrations
│   └── TinkerAvatar.swift         # Companion avatar
│
├── Models/
│   ├── ConsentRecord.swift        # User consent (Core Data)
│   ├── Suggestion.swift           # Suggestions (Core Data)
│   ├── SuggestionFeedback.swift   # Feedback (Core Data)
│   └── AppSettings.swift          # Settings (Core Data)
│
├── Services/
│   ├── NotificationService.swift  # Push notifications
│   ├── WidgetService.swift        # Widget sync
│   ├── DataExportService.swift    # Export/Delete data
│   └── LocalizationManager.swift  # i18n management
│
├── Stores/
│   ├── SettingsStore.swift        # Settings state
│   └── PersistenceController.swift # Core Data setup
│
├── Localization/
│   ├── en.lproj/Localizable.strings  # English (116 keys)
│   └── pt.lproj/Localizable.strings  # Portuguese (116 keys)
│
└── Widget/
    └── ClipBearWidget.swift       # Home screen widget
```

---

## 🚀 **Como Rodar**

### **Requisitos**:
- macOS 14.0+
- Xcode 15.0+
- iOS Simulator ou iPhone com iOS 15.0+

### **Passos**:

1. **Abrir Projeto**:
   ```bash
   cd /Users/drico/Desktop/AssistenteIA/ios/ClipBear
   open ClipBear.xcodeproj
   ```

2. **Selecionar Device**:
   - iPhone 17 (simulator) - Recomendado ✅
   - Ou qualquer iPhone/iPad

3. **Run** (Cmd+R):
   ```
   Product > Run
   ```

4. **Tests** (Cmd+U):
   ```
   Product > Test
   ```

---

## ⚙️ **Setup Adicional (Opcional)**

### **Para Widget Funcionar**:
Seguir `APP_GROUP_SETUP.md`:
1. Habilitar App Group: `group.com.clipbear.mvp`
2. Aplicar para ClipBear + ClipBearWidget targets

### **Para Deep Link Funcionar**:
Adicionar URL Scheme em Info.plist:
- Identifier: `com.clipbear.mvp`
- URL Schemes: `clipbear`

---

## 🧪 **Testes**

### **Unit Tests**: 30+ tests
```bash
xcodebuild test -project ClipBear.xcodeproj -scheme ClipBear -destination 'platform=iOS Simulator,name=iPhone 17'
```

**Cobertura**:
- ✅ LocalizationManager (5 tests)
- ✅ ConsentRecord (7 tests)
- ✅ NotificationService (2 tests)
- ✅ Core Data Model (9 tests)
- ✅ AppSettings, SettingsStore, Suggestion

### **UI Tests**:
- ✅ OnboardingUITests - Fluxo completo de onboarding

---

## 📖 **Documentação**

### **Para Desenvolvedores**:
- `TESTFLIGHT_READY.md` - QA e deploy guide
- `APP_GROUP_SETUP.md` - Widget setup
- `PR_IMPLEMENTATION_STATUS.md` - Changelog detalhado

### **Para Testadores**:
- `COMO_TESTAR.md` - Guia completo de testes
- `TESTING_CHECKLIST.md` - Checklist de QA

### **Para Stakeholders**:
- `IMPLEMENTATION_COMPLETE.md` - Resumo executivo
- `iOS_PROJECT_ANALYSIS.md` - Análise técnica

---

## 🔒 **Privacidade**

ClipBear foi projetado com privacidade em primeiro lugar:

- ✅ **Nunca lemos mensagens** - Apenas detectamos apps
- ✅ **Dados no dispositivo** - Nada enviado para servidores
- ✅ **Consent explícito** - Usuário tem controle total
- ✅ **Export/Delete** - Transparência total
- ✅ **Sem analytics** - Sem tracking de terceiros

Ver `PRIVACY.md` para política completa.

---

## 🌍 **Localização**

### **Idiomas Suportados**:
- 🇺🇸 **English** - 116 strings traduzidas
- 🇧🇷 **Português** - 116 strings traduzidas

### **Dynamic Loading**:
Usuário pode trocar idioma em Settings e UI atualiza instantaneamente sem restart.

**Files**:
- `en.lproj/Localizable.strings`
- `pt.lproj/Localizable.strings`

---

## 🛠️ **Development**

### **Build Commands**:

```bash
# Clean build
xcodebuild -project ClipBear.xcodeproj -scheme ClipBear clean build

# Run tests
xcodebuild test -project ClipBear.xcodeproj -scheme ClipBear -destination 'platform=iOS Simulator,name=iPhone 17'

# Archive (for TestFlight)
xcodebuild archive -project ClipBear.xcodeproj -scheme ClipBear -configuration Release -archivePath ClipBear.xcarchive
```

### **Debugging**:
- Enable logs em Settings > Diagnostics
- Console mostra eventos importantes:
  - ✅ Published suggestion to widget
  - ✅ Loaded language bundle for: [lang]
  - ✅ Consent saved successfully

---

## 📦 **Core Data Model**

### **Entities** (4):

1. **ConsentRecord**:
   - timestamp, scopes, language, version
   - Uniqueness: None (stores history)

2. **Suggestion**:
   - id, timestamp, ruleId, message, explanation
   - language, isShown, isAccepted, sessionId

3. **SuggestionFeedback**:
   - id, timestamp, ruleId, accepted, sessionId

4. **AppSettings**:
   - key, value, timestamp
   - Uniqueness: key (constraint)

---

## 🎨 **Design System**

### **Colors**:
- Primary: Blue (system)
- Background: System background (light/dark mode)
- Accent: Blue
- Secondary: Gray

### **Typography**:
- Display: Large Title (bold)
- Headline: Headline (semibold)
- Body: Body
- Caption: Caption2

### **Spacing**:
- Small: 8pt
- Medium: 16pt
- Large: 24pt
- XLarge: 32pt

---

## ♿ **Accessibility**

### **VoiceOver Support**:
- ✅ Todos botões com labels
- ✅ Navigation hints
- ✅ Widget acessível
- ✅ Settings toggles labeled

### **Dynamic Type**:
- ✅ Todos textos usam system fonts
- ✅ Layout adapta a text size

### **Contrast**:
- ✅ Primary buttons atendem WCAG AA
- ✅ Text readable em light/dark mode

---

## 🐛 **Known Issues**

Nenhum! 🎉

Todos os bugs foram corrigidos durante a implementação dos PRs.

---

## 📈 **Versioning**

### **Current: v1.0 (MVP)**
- Onboarding
- Settings
- Notifications
- Widget
- Data Export/Delete

### **Future (v2.0)**:
- Real integrations (food delivery, calendar)
- Machine learning suggestions
- Advanced analytics
- Multi-device sync

---

## 👥 **Contributing**

Este projeto seguiu o processo de 11 PRs focados:
1. LocalizationManager
2. ConsentRecord
3. SettingsStore
4. NotificationService
5. Widget
6. DataExportService
7. Core Data Model
8. Accessibility
9. Onboarding
10. Tests
11. UX Fixes

Cada PR tem acceptance checklist e é testável independentemente.

---

## 📄 **License**

Ver `LICENSE` file

---

## 📞 **Contato**

Para questões ou suporte, veja documentação em:
- `TESTFLIGHT_READY.md` - Para deploy
- `COMO_TESTAR.md` - Para testes
- `APP_GROUP_SETUP.md` - Para setup

---

**🚀 Ready for TestFlight! 🚀**

*Last Updated: 2025-10-06*  
*Build: ✅ SUCCESS*  
*Tests: ✅ 30+ PASSING*  
*PRs: ✅ 11/11 COMPLETE*

