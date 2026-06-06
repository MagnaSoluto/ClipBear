# 11 — Acessibilidade

## Resumo

Conformidade WCAG 2.1 AA. Suporte a TalkBack (Android) e VoiceOver (iOS).

## Requisitos

| Requisito | Implementação |
|-----------|---------------|
| Screen readers | Semantics widgets em todos os elementos interativos |
| Dynamic Type | Textos escaláveis (Flutter `textScaleFactor`) |
| Alto contraste | Tema com contraste ≥ 4.5:1 |
| Navegação por foco | Tab order lógico em todos os formulários |
| Touch targets | Mínimo 48x48dp |

## Labels de acessibilidade

| Elemento | Label EN | Label PT |
|----------|----------|----------|
| Avatar Tinker | "Tinker, companion avatar, state: {state}" | "Tinker, avatar companheiro, estado: {state}" |
| Toggle overlay | "Toggle in-app companion" | "Alternar companheiro no app" |
| Botão configurações | "Open settings" | "Abrir configurações" |
| Aceitar sugestão | "Accept suggestion" | "Aceitar sugestão" |
| Rejeitar sugestão | "Reject suggestion" | "Rejeitar sugestão" |
| Exportar dados | "Export all data" | "Exportar todos os dados" |
| Apagar dados | "Delete all data" | "Apagar todos os dados" |
| Checkbox consent | "Accept privacy terms" | "Aceitar termos de privacidade" |

## Estados do avatar (acessibilidade)

| Estado | EN | PT |
|--------|----|----|
| idle | "idle" | "repouso" |
| suggest | "suggesting" | "sugerindo" |
| speak | "speaking" | "falando" |

## FlutterFlow

- Usar widget **Semantics** em componentes customizados
- Configurar `semanticLabel` em botões e toggles
- Testar com TalkBack/VoiceOver em dispositivos reais

## Critérios de aceite

- [ ] Todos os botões têm semantic labels
- [ ] Avatar anuncia estado atual
- [ ] Sugestões são lidas pelo screen reader
- [ ] Contraste de cores ≥ 4.5:1
- [ ] Touch targets ≥ 48dp
- [ ] Navegação por tab funciona em onboarding e settings
