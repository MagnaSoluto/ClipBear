# 09 — Dados & Persistência

## Resumo

Armazenamento local criptografado. Sem nuvem. Export JSON e delete completo.

## Entidades

### ConsentRecord

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|-------------|-----------|
| timestamp | DateTime | sim | Momento do consentimento |
| version | String | sim | Versão da política ("1.0") |
| language | String | sim | Idioma aceito ("en"/"pt") |
| scopes | String | sim | Escopos aceitos (CSV) |

### Suggestion

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|-------------|-----------|
| id | UUID | sim | Identificador único |
| message | String | sim | Texto da sugestão |
| explanation | String | sim | Texto "Por quê?" |
| ruleId | String | sim | Regra que gerou |
| sessionId | String | sim | Sessão do usuário |
| language | String | sim | Idioma da sugestão |
| timestamp | DateTime | sim | Quando foi criada |
| isShown | bool | sim | Se foi exibida ao usuário |
| isAccepted | bool | sim | Feedback do usuário |
| feedbackTimestamp | DateTime? | não | Quando feedback foi dado |

### SuggestionFeedback

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|-------------|-----------|
| id | UUID | sim | Identificador único |
| ruleId | String | sim | Regra relacionada |
| sessionId | String | sim | Sessão |
| accepted | bool | sim | true=aceito, false=rejeitado |
| timestamp | DateTime | sim | Momento do feedback |

### AppSettings (key-value)

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|-------------|-----------|
| key | String | sim | Chave única |
| value | String | sim | Valor serializado |
| timestamp | DateTime | sim | Última atualização |

### Chaves de AppSettings

| Key | Valor padrão | Descrição |
|-----|--------------|-----------|
| `language` | `"en"` | Idioma |
| `intensity` | `"basic"` | Intensidade |
| `overlayEnabled` | `"false"` | Overlay ativo |
| `snoozeUntil` | `"0"` | Timestamp snooze |
| `diagnosticsEnabled` | `"false"` | Diagnósticos |
| `overlayPosition` | `"bottom-right"` | Posição do avatar |
| `dailySuggestionCount` | `"0"` | Contador do dia |
| `lastCounterReset` | timestamp | Último reset |

## Tecnologia de persistência

| Opção | Prós | Contras |
|-------|------|---------|
| **Hive** (recomendado) | Rápido, simples, encryption built-in | Sem queries complexas |
| SQLite (drift) | Queries SQL | Mais setup |
| FlutterFlow App State | Integrado | Não persiste sozinho |

**Recomendação**: Hive com encryption para MVP.

## Export JSON

Custom Action `exportAllData()`:

1. Ler todas as entidades
2. Serializar para JSON
3. Salvar em arquivo temporário
4. Abrir share sheet (`share_plus` package)

## Delete All

Custom Action `deleteAllData()`:

1. Mostrar confirmação ("Tem certeza? Esta ação não pode ser desfeita.")
2. Segunda confirmação
3. Apagar todas as entidades
4. Limpar widget
5. Resetar AppState
6. Redirecionar para onboarding

## Privacidade

- Dados criptografados com chave do dispositivo
- Nenhum dado enviado para servidores
- Export sob controle do usuário
- Delete irreversível e completo

## Critérios de aceite

- [ ] 4 entidades persistem corretamente
- [ ] Dados sobrevivem restart do app
- [ ] Export gera JSON válido e completo
- [ ] Delete apaga tudo e redireciona para onboarding
- [ ] Criptografia ativa (Hive encrypted box)
- [ ] Nenhuma chamada de rede
