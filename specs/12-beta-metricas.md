# 12 — Beta & Métricas

## Resumo

Plano de teste beta para validar hipóteses do MVP. Métricas locais, sem analytics em nuvem.

## Objetivos do beta

1. Usuários gostam de interagir com companheiro flutuante?
2. Usuários aceitam sugestões baseadas em comportamento?
3. Usuários se sentem confortáveis com privacidade?
4. Quais features ressoam mais?

## Métricas de sucesso

| Métrica | Threshold | Como medir |
|---------|-----------|------------|
| Taxa de aceitação | ≥ 15% | `accepted / total_suggestions` |
| Engajamento conversacional | ≥ 1/dia | `interactions / active_days` |
| Retenção D7 | ≥ 25% | `active_day_7 / installed` |
| Satisfação privacidade | ≥ 80% | Pesquisa (escala 1-5, ≥4) |

## Grupos A/B

| Grupo | Intensidade | Sugestões/dia |
|-------|-------------|---------------|
| A (Basic) | `basic` | 1-2 |
| B (Proactive) | `proactive` | até 4 |
| Hard cap | ambos | máximo 5 |

Atribuição: aleatória no primeiro launch, persistida em AppSettings.

## Coleta de métricas (local)

Todas as métricas derivadas dos dados já persistidos:

```dart
// Taxa de aceitação
double acceptanceRate = suggestions.where((s) => s.isAccepted).length / suggestions.length;

// Engajamento diário
int dailyInteractions = feedback.where((f) => isToday(f.timestamp)).length;

// Retenção
bool isActiveDay7 = suggestions.any((s) => isDay(s.timestamp, 7));
```

**Sem analytics em nuvem.** Export JSON para análise manual.

## Pesquisas

### Onboarding (dia 0)

1. O que te interessou em experimentar o ClipBear?
2. Quais suas preocupações sobre privacidade?
3. O que espera desta experiência?

### Check-in semanal

1. Com que frequência interage com o Tinker?
2. Sugestões são úteis? (1-5)
3. Confortável com tratamento de dados? (1-5)
4. Feature favorita?
5. O que mudaria?
6. Continuaria usando após o beta?

### Final (dia 14)

1. Satisfação geral (1-5)
2. Recomendaria? (1-5)
3. Feature mais valiosa
4. Maior preocupação
5. Sugestões de melhoria

## Critérios de decisão

### Go (continuar)

- Todas as 4 métricas ≥ threshold
- Satisfação geral ≥ 3.5/5

### Pivot (modificar)

- 1+ métricas abaixo do threshold
- Feedback negativo consistente

### Kill (parar)

- Aceitação < 10%
- Engajamento < 0.5/dia
- Retenção D7 < 15%
- Satisfação < 3.0/5

## Critérios de aceite

- [ ] Grupo A/B atribuído no primeiro launch
- [ ] Métricas calculáveis via export JSON
- [ ] Pesquisas preparadas EN/PT (Google Forms ou similar)
- [ ] Critérios go/pivot/kill documentados
