# 06 — Configurações

## Resumo

Tela de preferências do usuário: idioma, intensidade de sugestões, snooze, diagnósticos e gestão de dados.

## Seções

### 1. Idioma

| Opção | Valor |
|-------|-------|
| English | `en` |
| Português | `pt` |

- Troca imediata de todas as strings
- Persiste em `AppSettings.language`

### 2. Intensidade de Sugestões

| Opção | Valor | Limite/dia |
|-------|-------|------------|
| Básico (1-2/dia) | `basic` | 2 |
| Proativo (até 4/dia) | `proactive` | 4 |

- Descrição: "Com que frequência o Tinker deve fazer sugestões?"
- Hard cap global: 5 (independente do modo)

### 3. Soneca (Snooze)

| Opção | Duração |
|-------|---------|
| 1 hora | `now + 1h` |
| 24 horas | `now + 24h` |

- Persiste `snoozeUntil` em AppSettings
- Enquanto snoozed, RuleEngine não dispara
- Indicador visual na tela principal quando ativo

### 4. Diagnósticos

| Campo | Padrão |
|-------|--------|
| `diagnosticsEnabled` | `false` |

- Opt-in explícito
- Logs locais criptografados (nunca enviados)
- Toggle com descrição: "Ativar logging local para debug (dados ficam no dispositivo)"

### 5. Gestão de Dados

| Ação | Comportamento |
|------|---------------|
| Exportar Dados | Gera JSON com todos os registros, compartilha via share sheet |
| Apagar Tudo | Confirmação dupla → delete batch de todas as entidades |

## Formato de export JSON

```json
{
  "exportVersion": "1.0",
  "exportedAt": "2026-06-06T12:00:00Z",
  "consentRecords": [...],
  "suggestions": [...],
  "suggestionFeedback": [...],
  "appSettings": [...]
}
```

## Página FlutterFlow

| Página | Rota |
|--------|------|
| Settings | `/settings` |

## AppState (FlutterFlow)

| Variável | Tipo | Persistência |
|----------|------|--------------|
| `language` | String | Hive/SQLite |
| `intensity` | String | Hive/SQLite |
| `snoozeUntil` | DateTime? | Hive/SQLite |
| `overlayEnabled` | bool | Hive/SQLite |
| `diagnosticsEnabled` | bool | Hive/SQLite |

## Critérios de aceite

- [ ] Troca de idioma reflete imediatamente na UI
- [ ] Intensidade altera limite diário de sugestões
- [ ] Snooze bloqueia sugestões pelo período
- [ ] Export gera JSON válido com todos os dados
- [ ] Delete apaga tudo com confirmação dupla
- [ ] Diagnósticos off por padrão
- [ ] Todas as strings localizadas
