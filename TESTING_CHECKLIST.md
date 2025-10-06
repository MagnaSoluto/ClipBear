# Testing Checklist - ClipBear MVP

## Pre-Build Checklist

### Code Quality
- [ ] All strings have EN/PT translations (build fails if missing)
- [ ] Database schema migration tests pass
- [ ] Unit tests coverage ≥ 80%
- [ ] Lint checks pass (Android: ktlint, iOS: SwiftLint)
- [ ] No hardcoded strings (all externalized)
- [ ] Accessibility labels present on all interactive elements

### Security & Privacy
- [ ] No network calls in release builds
- [ ] All data encrypted locally
- [ ] No personal data in logs
- [ ] Privacy policy accessible from app
- [ ] Data export/delete functions work
- [ ] Opt-in permissions properly implemented

## Pre-Beta Checklist

### Core Features
- [ ] Overlay bubble shows/hides correctly
- [ ] Avatar animations work smoothly
- [ ] Onboarding flow completes successfully
- [ ] All 3 behavioral rules trigger correctly
- [ ] Suggestions show explainability
- [ ] Settings save/load properly
- [ ] Language switching works
- [ ] Snooze functionality works

### Permissions
- [ ] UsageStats permission rationale shown
- [ ] Overlay permission rationale shown
- [ ] App works when permissions denied
- [ ] Fallback behavior implemented

### Accessibility
- [ ] TalkBack/VoiceOver navigation works
- [ ] Dynamic Type scaling works (1.3x minimum)
- [ ] High contrast mode supported
- [ ] Focus indicators visible
- [ ] All buttons have accessible labels

### Performance
- [ ] App launches in < 3 seconds
- [ ] Memory usage < 100MB
- [ ] Battery impact ≤ +5% in 24h test
- [ ] No memory leaks detected
- [ ] Smooth 60fps animations

## Beta Testing Checklist

### A/B Testing Setup
- [ ] Group A (Basic): 1-2 suggestions/day
- [ ] Group B (Proactive): Up to 4 suggestions/day
- [ ] Hard cap: Maximum 5 suggestions/day
- [ ] Group assignment randomized
- [ ] Metrics tracked by group

### Data Collection
- [ ] Acceptance rate tracked
- [ ] Conversational engagement tracked
- [ ] D1/D7 retention tracked
- [ ] Battery impact measured
- [ ] Privacy satisfaction surveyed
- [ ] Uninstall rate by group

### User Experience
- [ ] Onboarding completion rate ≥ 90%
- [ ] Overlay opt-in rate tracked
- [ ] Suggestion interaction rate tracked
- [ ] Settings usage tracked
- [ ] Crash rate < 1%

## Post-Beta Analysis

### Success Criteria
- [ ] Acceptance Rate ≥ 15%
- [ ] Conversational Engagement ≥ 1 interaction/day
- [ ] D7 Retention ≥ 25%
- [ ] Privacy Satisfaction ≥ 80%
- [ ] Overall Satisfaction ≥ 3.5/5

### Decision Framework
- [ ] All metrics above threshold → Go decision
- [ ] One metric below threshold → Pivot decision
- [ ] Multiple metrics below threshold → Kill decision
- [ ] User feedback analyzed
- [ ] Technical issues documented

## Schema Migration Testing

### Android (Room)
```kotlin
// Test database migration
@Test
fun testDatabaseMigration() {
    val migration = Migration(1, 2) { database ->
        // Test migration logic
    }
    // Verify data integrity
}
```

### iOS (CoreData)
```swift
// Test CoreData migration
func testCoreDataMigration() {
    // Test light migration
    // Verify data integrity
}
```

## String Coverage Testing

### Android
```bash
# Check for missing translations
./gradlew checkStrings
# Should fail if any string missing PT translation
```

### iOS
```bash
# Check for missing translations
# Add build phase to fail if strings missing
```

## Battery Testing Protocol

### 24-Hour Test
1. **Baseline**: Use device normally for 24h without app
2. **With App**: Use device with ClipBear for 24h
3. **Measure**: Compare battery consumption
4. **Target**: ≤ +5% increase

### Tools
- **Android**: Battery Historian, Perfetto
- **iOS**: Instruments Energy Log
- **Both**: Device battery settings

## Accessibility Testing Protocol

### Android (TalkBack)
1. Enable TalkBack in Settings
2. Navigate through entire app
3. Verify all elements accessible
4. Test with different font sizes
5. Test in high contrast mode

### iOS (VoiceOver)
1. Enable VoiceOver in Settings
2. Navigate through entire app
3. Verify all elements accessible
4. Test with different font sizes
5. Test in high contrast mode

## Performance Testing Protocol

### Memory Testing
- Monitor memory usage over 24h
- Check for memory leaks
- Target: < 100MB peak usage

### CPU Testing
- Monitor CPU usage during normal use
- Check for excessive background processing
- Target: < 5% average CPU usage

### Launch Time Testing
- Measure app launch time
- Test on different device specs
- Target: < 3 seconds cold start

## Security Testing Protocol

### Data Encryption
- Verify all data encrypted at rest
- Test encryption key derivation
- Verify keys never transmitted

### Network Security
- Confirm no network calls in release
- Test with network monitoring
- Verify opt-in for any external calls

### Privacy Compliance
- Test data export functionality
- Test data deletion functionality
- Verify user consent tracking
- Test privacy policy accessibility

---

# Checklist de Testes - ClipBear MVP

## Checklist Pré-Build

### Qualidade do Código
- [ ] Todas as strings têm traduções EN/PT (build falha se faltar)
- [ ] Testes de migração de schema do banco passam
- [ ] Cobertura de testes unitários ≥ 80%
- [ ] Verificações de lint passam (Android: ktlint, iOS: SwiftLint)
- [ ] Nenhuma string hardcoded (todas externalizadas)
- [ ] Labels de acessibilidade presentes em todos os elementos interativos

### Segurança e Privacidade
- [ ] Nenhuma chamada de rede em builds de release
- [ ] Todos os dados criptografados localmente
- [ ] Nenhum dado pessoal em logs
- [ ] Política de privacidade acessível do app
- [ ] Funções de exportar/deletar dados funcionam
- [ ] Permissões opt-in implementadas corretamente

## Checklist Pré-Beta

### Funcionalidades Principais
- [ ] Bolha de overlay aparece/desaparece corretamente
- [ ] Animações do avatar funcionam suavemente
- [ ] Fluxo de onboarding completa com sucesso
- [ ] Todas as 3 regras comportamentais disparam corretamente
- [ ] Sugestões mostram explicabilidade
- [ ] Configurações salvam/carregam corretamente
- [ ] Troca de idioma funciona
- [ ] Funcionalidade de soneca funciona

### Permissões
- [ ] Justificativa da permissão UsageStats mostrada
- [ ] Justificativa da permissão Overlay mostrada
- [ ] App funciona quando permissões negadas
- [ ] Comportamento de fallback implementado

### Acessibilidade
- [ ] Navegação TalkBack/VoiceOver funciona
- [ ] Escalonamento Dynamic Type funciona (1.3x mínimo)
- [ ] Modo alto contraste suportado
- [ ] Indicadores de foco visíveis
- [ ] Todos os botões têm labels acessíveis

### Performance
- [ ] App inicia em < 3 segundos
- [ ] Uso de memória < 100MB
- [ ] Impacto na bateria ≤ +5% em teste de 24h
- [ ] Nenhum vazamento de memória detectado
- [ ] Animações suaves a 60fps

## Checklist de Teste Beta

### Configuração A/B
- [ ] Grupo A (Básico): 1-2 sugestões/dia
- [ ] Grupo B (Proativo): Até 4 sugestões/dia
- [ ] Limite rígido: Máximo 5 sugestões/dia
- [ ] Atribuição de grupo randomizada
- [ ] Métricas rastreadas por grupo

### Coleta de Dados
- [ ] Taxa de aceitação rastreada
- [ ] Engajamento conversacional rastreado
- [ ] Retenção D1/D7 rastreada
- [ ] Impacto na bateria medido
- [ ] Satisfação com privacidade pesquisada
- [ ] Taxa de desinstalação por grupo

### Experiência do Usuário
- [ ] Taxa de conclusão do onboarding ≥ 90%
- [ ] Taxa de opt-in do overlay rastreada
- [ ] Taxa de interação com sugestões rastreada
- [ ] Uso de configurações rastreado
- [ ] Taxa de crash < 1%

## Análise Pós-Beta

### Critérios de Sucesso
- [ ] Taxa de Aceitação ≥ 15%
- [ ] Engajamento Conversacional ≥ 1 interação/dia
- [ ] Retenção D7 ≥ 25%
- [ ] Satisfação com Privacidade ≥ 80%
- [ ] Satisfação Geral ≥ 3.5/5

### Framework de Decisão
- [ ] Todas as métricas acima do limite → Decisão Go
- [ ] Uma métrica abaixo do limite → Decisão Pivot
- [ ] Múltiplas métricas abaixo do limite → Decisão Kill
- [ ] Feedback do usuário analisado
- [ ] Problemas técnicos documentados

## Teste de Migração de Schema

### Android (Room)
```kotlin
// Teste de migração do banco
@Test
fun testDatabaseMigration() {
    val migration = Migration(1, 2) { database ->
        // Testar lógica de migração
    }
    // Verificar integridade dos dados
}
```

### iOS (CoreData)
```swift
// Teste de migração CoreData
func testCoreDataMigration() {
    // Testar migração leve
    // Verificar integridade dos dados
}
```

## Teste de Cobertura de Strings

### Android
```bash
# Verificar traduções faltantes
./gradlew checkStrings
# Deve falhar se alguma string PT faltar
```

### iOS
```bash
# Verificar traduções faltantes
# Adicionar fase de build para falhar se strings faltarem
```

## Protocolo de Teste de Bateria

### Teste de 24 Horas
1. **Baseline**: Usar dispositivo normalmente por 24h sem app
2. **Com App**: Usar dispositivo com ClipBear por 24h
3. **Medir**: Comparar consumo de bateria
4. **Meta**: ≤ +5% de aumento

### Ferramentas
- **Android**: Battery Historian, Perfetto
- **iOS**: Instruments Energy Log
- **Ambos**: Configurações de bateria do dispositivo

## Protocolo de Teste de Acessibilidade

### Android (TalkBack)
1. Habilitar TalkBack nas Configurações
2. Navegar por todo o app
3. Verificar todos os elementos acessíveis
4. Testar com diferentes tamanhos de fonte
5. Testar em modo alto contraste

### iOS (VoiceOver)
1. Habilitar VoiceOver nas Configurações
2. Navegar por todo o app
3. Verificar todos os elementos acessíveis
4. Testar com diferentes tamanhos de fonte
5. Testar em modo alto contraste

## Protocolo de Teste de Performance

### Teste de Memória
- Monitorar uso de memória por 24h
- Verificar vazamentos de memória
- Meta: < 100MB uso máximo

### Teste de CPU
- Monitorar uso de CPU durante uso normal
- Verificar processamento excessivo em background
- Meta: < 5% uso médio de CPU

### Teste de Tempo de Inicialização
- Medir tempo de inicialização do app
- Testar em diferentes especificações de dispositivo
- Meta: < 3 segundos inicialização a frio

## Protocolo de Teste de Segurança

### Criptografia de Dados
- Verificar todos os dados criptografados em repouso
- Testar derivação de chaves de criptografia
- Verificar chaves nunca transmitidas

### Segurança de Rede
- Confirmar nenhuma chamada de rede em release
- Testar com monitoramento de rede
- Verificar opt-in para qualquer chamada externa

### Conformidade de Privacidade
- Testar funcionalidade de exportar dados
- Testar funcionalidade de deletar dados
- Verificar rastreamento de consentimento do usuário
- Testar acessibilidade da política de privacidade
