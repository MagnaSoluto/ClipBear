# Build Instructions - ClipBear MVP

## Prerequisites

### Android Development
- Android Studio Arctic Fox or later
- Android SDK 26+ (API Level 26)
- Kotlin 1.9.10+
- Gradle 8.0+

### iOS Development
- Xcode 15.0+
- iOS 14.0+ deployment target
- Swift 5.9+

## Android Build

### 1. Setup
```bash
cd android
./gradlew clean
```

### 2. Dependencies
The project uses the following key dependencies:
- Jetpack Compose for UI
- Room + SQLCipher for encrypted storage
- Navigation Compose for navigation
- Hilt for dependency injection
- Accompanist Permissions for permission handling

### 3. Build
```bash
# Debug build
./gradlew assembleDebug

# Release build
./gradlew assembleRelease
```

### 4. Install
```bash
# Install debug APK
adb install app/build/outputs/apk/debug/app-debug.apk

# Install release APK
adb install app/build/outputs/apk/release/app-release.apk
```

### 5. Permissions

#### Required Permissions
- `SYSTEM_ALERT_WINDOW` - For overlay functionality (opt-in only)
- `PACKAGE_USAGE_STATS` - For usage statistics
- `INTERNET` - For future network features
- `WAKE_LOCK` - For background processing

#### Permission Rationale Screens
- **UsageStats**: Show rationale screen before system dialog
- **Overlay**: Opt-in only with clear declaration and rationale
- **Fallback**: If permissions denied, app continues with available signals

#### UsageStats Setup
```bash
# Enable UsageStats permission
adb shell dumpsys usagestats
# Or direct user to Settings > Apps > Special access > Usage access
```

#### Play Console Notes
- Declare `SYSTEM_ALERT_WINDOW` as opt-in feature
- Describe use case: "Floating companion bubble for digital wellness"
- Include rationale screens in app description

## iOS Build

### 1. Setup
```bash
cd ios
open ClipBear.xcodeproj
```

### 2. Dependencies
The project uses native iOS frameworks:
- SwiftUI for UI
- CoreData for encrypted storage
- Combine for reactive programming
- UserNotifications for notifications

### 3. Build
1. Open `ClipBear.xcodeproj` in Xcode
2. Select your target device or simulator
3. Press Cmd+B to build
4. Press Cmd+R to run

### 4. Permissions
The app requires the following permissions:
- Usage Statistics access
- Notification permissions (optional)

## Configuration

### Environment Variables
Create a `local.properties` file in the Android project root:
```properties
# Android
sdk.dir=/path/to/android/sdk
# Add any API keys here if needed
```

### Database Encryption
The app uses SQLCipher for Android and CoreData encryption for iOS. The encryption keys are derived from device-specific data and are never transmitted.

## Testing

### Unit Tests
```bash
# Android
./gradlew test

# iOS
# Run tests in Xcode (Cmd+U)
```

### UI Tests
```bash
# Android
./gradlew connectedAndroidTest

# iOS
# Run UI tests in Xcode
```

### Battery & Performance Testing

#### Android Battery Testing
```bash
# Capture baseline
adb shell dumpsys batterystats --reset
# Use app for 24 hours
adb shell dumpsys batterystats > battery_baseline.txt

# Capture with app
adb shell dumpsys batterystats --reset
# Use app for 24 hours
adb shell dumpsys batterystats > battery_with_app.txt

# Analyze with Battery Historian
# Target: ≤ +5% battery impact in 24h
```

#### iOS Battery Testing
- Use Instruments Energy Log
- Monitor for 24 hours
- Target: ≤ +5% battery impact

#### Performance Testing
```bash
# Android - Memory usage
adb shell dumpsys meminfo com.clipbear.mvp

# Android - CPU usage
adb shell top -p $(adb shell pidof com.clipbear.mvp)
```

### Accessibility Testing

#### Minimum Checks
- All elements have accessible labels
- Focus navigation validated
- Scalable font sizes (Dynamic Type / FontScale >= 1.3)
- Minimum contrast WCAG 2.1 AA (4.5:1 for normal text)

#### Android Accessibility
```bash
# Enable TalkBack
adb shell settings put secure enabled_accessibility_services com.google.android.marvin.talkback/com.google.android.marvin.talkback.TalkBackService

# Test with TalkBack enabled
```

#### iOS Accessibility
- Test with VoiceOver enabled
- Verify Dynamic Type scaling
- Check high contrast mode

## Beta Testing

### 1. Prepare Beta Build
- Ensure all features are implemented
- Test on multiple devices
- Verify privacy compliance
- Prepare beta distribution

### 2. Deploy to Testers
- Use TestFlight for iOS
- Use Google Play Console for Android
- Provide clear instructions
- Set up feedback collection

### 3. Monitor Metrics
- Track acceptance rates
- Monitor user engagement
- Collect feedback
- Analyze retention

## Troubleshooting

### Common Issues

#### Android
- **Overlay not showing**: Check `SYSTEM_ALERT_WINDOW` permission
- **Usage stats not working**: Check `PACKAGE_USAGE_STATS` permission
- **Database errors**: Verify SQLCipher setup
- **Build failures**: Check Gradle and SDK versions

#### iOS
- **Build errors**: Check Xcode and iOS versions
- **Permission issues**: Verify Info.plist configuration
- **CoreData errors**: Check encryption setup
- **Simulator issues**: Test on physical device

### Debug Mode
Enable debug logging by setting `diagnostics_enabled` to `true` in settings.

## Production Deployment

### Android
1. Generate signed APK
2. Upload to Google Play Console
3. Complete store listing
4. Submit for review

### iOS
1. Archive the app
2. Upload to App Store Connect
3. Complete store listing
4. Submit for review

## Security Considerations

- All data is encrypted locally
- No data is transmitted to external servers
- User consent is required for all data collection
- Data can be deleted at any time
- Privacy policy is included and accessible

## Support

For technical support or questions:
- Check the README.md for general information
- Review PRIVACY.md for privacy details
- See BETA_PLAN.md for testing information
- Contact: support@clipbear.app

---

# Instruções de Build - ClipBear MVP

## Pré-requisitos

### Desenvolvimento Android
- Android Studio Arctic Fox ou posterior
- Android SDK 26+ (Nível de API 26)
- Kotlin 1.9.10+
- Gradle 8.0+

### Desenvolvimento iOS
- Xcode 15.0+
- iOS 14.0+ como target de deployment
- Swift 5.9+

## Build Android

### 1. Configuração
```bash
cd android
./gradlew clean
```

### 2. Dependências
O projeto usa as seguintes dependências principais:
- Jetpack Compose para UI
- Room + SQLCipher para armazenamento criptografado
- Navigation Compose para navegação
- Hilt para injeção de dependência
- Accompanist Permissions para gerenciamento de permissões

### 3. Build
```bash
# Build de debug
./gradlew assembleDebug

# Build de release
./gradlew assembleRelease
```

### 4. Instalação
```bash
# Instalar APK de debug
adb install app/build/outputs/apk/debug/app-debug.apk

# Instalar APK de release
adb install app/build/outputs/apk/release/app-release.apk
```

### 5. Permissões

#### Permissões Obrigatórias
- `SYSTEM_ALERT_WINDOW` - Para funcionalidade de overlay (apenas opt-in)
- `PACKAGE_USAGE_STATS` - Para estatísticas de uso
- `INTERNET` - Para funcionalidades futuras de rede
- `WAKE_LOCK` - Para processamento em background

#### Telas de Justificativa de Permissões
- **UsageStats**: Mostrar tela de justificativa antes do diálogo do sistema
- **Overlay**: Apenas opt-in com declaração clara e justificativa
- **Fallback**: Se permissões negadas, app continua com sinais disponíveis

#### Configuração UsageStats
```bash
# Habilitar permissão UsageStats
adb shell dumpsys usagestats
# Ou direcionar usuário para Configurações > Apps > Acesso especial > Acesso ao uso
```

#### Notas do Play Console
- Declarar `SYSTEM_ALERT_WINDOW` como recurso opt-in
- Descrever caso de uso: "Bolha de companheiro flutuante para bem-estar digital"
- Incluir telas de justificativa na descrição do app

## Build iOS

### 1. Configuração
```bash
cd ios
open ClipBear.xcodeproj
```

### 2. Dependências
O projeto usa frameworks nativos do iOS:
- SwiftUI para UI
- CoreData para armazenamento criptografado
- Combine para programação reativa
- UserNotifications para notificações

### 3. Build
1. Abra `ClipBear.xcodeproj` no Xcode
2. Selecione seu dispositivo alvo ou simulador
3. Pressione Cmd+B para build
4. Pressione Cmd+R para executar

### 4. Permissões
O app requer as seguintes permissões:
- Acesso a Estatísticas de Uso
- Permissões de notificação (opcional)

## Configuração

### Variáveis de Ambiente
Crie um arquivo `local.properties` na raiz do projeto Android:
```properties
# Android
sdk.dir=/caminho/para/android/sdk
# Adicione chaves de API aqui se necessário
```

### Criptografia do Banco de Dados
O app usa SQLCipher para Android e criptografia CoreData para iOS. As chaves de criptografia são derivadas de dados específicos do dispositivo e nunca são transmitidas.

## Testes

### Testes Unitários
```bash
# Android
./gradlew test

# iOS
# Execute testes no Xcode (Cmd+U)
```

### Testes de UI
```bash
# Android
./gradlew connectedAndroidTest

# iOS
# Execute testes de UI no Xcode
```

### Testes de Bateria e Performance

#### Teste de Bateria Android
```bash
# Capturar baseline
adb shell dumpsys batterystats --reset
# Usar app por 24 horas
adb shell dumpsys batterystats > battery_baseline.txt

# Capturar com app
adb shell dumpsys batterystats --reset
# Usar app por 24 horas
adb shell dumpsys batterystats > battery_with_app.txt

# Analisar com Battery Historian
# Meta: ≤ +5% impacto na bateria em 24h
```

#### Teste de Bateria iOS
- Usar Instruments Energy Log
- Monitorar por 24 horas
- Meta: ≤ +5% impacto na bateria

#### Teste de Performance
```bash
# Android - Uso de memória
adb shell dumpsys meminfo com.clipbear.mvp

# Android - Uso de CPU
adb shell top -p $(adb shell pidof com.clipbear.mvp)
```

### Teste de Acessibilidade

#### Verificações Mínimas
- Todos os elementos têm labels acessíveis
- Navegação por foco validada
- Tamanhos de fonte escaláveis (Dynamic Type / FontScale >= 1.3)
- Contraste mínimo WCAG 2.1 AA (4.5:1 para texto normal)

#### Acessibilidade Android
```bash
# Habilitar TalkBack
adb shell settings put secure enabled_accessibility_services com.google.android.marvin.talkback/com.google.android.marvin.talkback.TalkBackService

# Testar com TalkBack habilitado
```

#### Acessibilidade iOS
- Testar com VoiceOver habilitado
- Verificar escalonamento Dynamic Type
- Verificar modo alto contraste

## Teste Beta

### 1. Preparar Build Beta
- Garantir que todas as funcionalidades estão implementadas
- Testar em múltiplos dispositivos
- Verificar conformidade com privacidade
- Preparar distribuição beta

### 2. Implantar para Testadores
- Usar TestFlight para iOS
- Usar Google Play Console para Android
- Fornecer instruções claras
- Configurar coleta de feedback

### 3. Monitorar Métricas
- Rastrear taxas de aceitação
- Monitorar engajamento do usuário
- Coletar feedback
- Analisar retenção

## Solução de Problemas

### Problemas Comuns

#### Android
- **Overlay não aparece**: Verificar permissão `SYSTEM_ALERT_WINDOW`
- **Estatísticas de uso não funcionam**: Verificar permissão `PACKAGE_USAGE_STATS`
- **Erros de banco de dados**: Verificar configuração SQLCipher
- **Falhas de build**: Verificar versões Gradle e SDK

#### iOS
- **Erros de build**: Verificar versões Xcode e iOS
- **Problemas de permissão**: Verificar configuração Info.plist
- **Erros CoreData**: Verificar configuração de criptografia
- **Problemas de simulador**: Testar em dispositivo físico

### Modo Debug
Habilitar logging de debug definindo `diagnostics_enabled` como `true` nas configurações.

## Implantação em Produção

### Android
1. Gerar APK assinado
2. Fazer upload para Google Play Console
3. Completar listagem da loja
4. Enviar para revisão

### iOS
1. Arquivar o app
2. Fazer upload para App Store Connect
3. Completar listagem da loja
4. Enviar para revisão

## Considerações de Segurança

- Todos os dados são criptografados localmente
- Nenhum dado é transmitido para servidores externos
- Consentimento do usuário é necessário para toda coleta de dados
- Dados podem ser deletados a qualquer momento
- Política de privacidade está incluída e acessível

## Suporte

Para suporte técnico ou dúvidas:
- Consulte o README.md para informações gerais
- Revise PRIVACY.md para detalhes de privacidade
- Veja BETA_PLAN.md para informações de teste
- Contato: support@clipbear.app

