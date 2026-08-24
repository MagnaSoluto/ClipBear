# 02 — Onboarding & Consentimento

## Resumo

Fluxo de 4 etapas que apresenta o app, explica privacidade, solicita permissões e registra consentimento explícito.

## Fluxo

```
Welcome → Privacy → Permissions → Consent → Main
```

## Etapa 1: Welcome

| Campo | Valor |
|-------|-------|
| Título | "Bem-vindo ao ClipBear!" |
| Subtítulo | "Seu companheiro digital que observa seus hábitos e oferece sugestões úteis." |
| Avatar | Tinker em estado `idle`, animado |
| Botão | "Próximo" |

## Etapa 2: Privacy

| Campo | Valor |
|-------|-------|
| Título | "Privacidade em Primeiro Lugar" |
| Conteúdo | Lista com bullets: |
| | • Nunca lemos suas mensagens |
| | • Apenas detectamos qual app está em primeiro plano |
| | • Todos os dados ficam no seu dispositivo |
| | • Você pode deletar ou exportar seus dados a qualquer momento |
| Botões | "Voltar" / "Próximo" |

## Etapa 3: Permissions

| Campo | Valor |
|-------|-------|
| Título | "Permissões Necessárias" |
| Conteúdo | Lista com justificativa: |
| | • Notificações: para mostrar sugestões úteis |
| | • Widget: para exibir companheiro na home screen |
| | • Todas as permissões são opcionais e podem ser revogadas |
| Botões | "Voltar" / "Próximo" |

**Comportamento**: Ao avançar, solicitar permissão de notificações. Se negada, continuar sem bloquear.

## Etapa 4: Consent

| Campo | Valor |
|-------|-------|
| Título | "Pronto para Começar!" |
| Checkbox | "Aceito os termos de privacidade e quero usar o ClipBear." |
| Botão | "Começar" (desabilitado até checkbox marcado) |

## Registro de consentimento

Ao clicar "Começar", criar `ConsentRecord`:

```dart
ConsentRecord {
  timestamp: DateTime.now(),
  version: "1.0",           // versão da política de privacidade
  language: "pt" | "en",    // idioma selecionado
  scopes: "overlay,notifications,usage_patterns"
}
```

## Detecção de idioma

1. Detectar locale do dispositivo (`pt` ou `en`)
2. Permitir troca manual na etapa Welcome (toggle EN/PT)
3. Persistir escolha em `AppSettings.language`

## Páginas FlutterFlow

| Página | Rota |
|--------|------|
| OnboardingWelcome | `/onboarding/welcome` |
| OnboardingPrivacy | `/onboarding/privacy` |
| OnboardingPermissions | `/onboarding/permissions` |
| OnboardingConsent | `/onboarding/consent` |

## Navegação pós-onboarding

- Se `ConsentRecord` existe → ir direto para `Main`
- Se não existe → mostrar onboarding
- Verificar no `AppState` ao iniciar

## Critérios de aceite

- [ ] 4 etapas navegáveis com voltar/avançar
- [ ] Detecção automática de idioma PT/EN
- [ ] Troca manual de idioma funciona
- [ ] Checkbox obrigatório na etapa final
- [ ] ConsentRecord salvo com timestamp e versão
- [ ] Onboarding não reaparece após conclusão
- [ ] Permissão de notificação solicitada (sem bloquear se negada)
- [ ] Todas as strings localizadas EN/PT
