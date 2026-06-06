// Custom Action: RuleEngine
// Implementar após export do FlutterFlow.
// Spec: specs/03-regras-comportamentais.md

/// Snapshot de uso do dispositivo para avaliação de regras.
class UsageSnapshot {
  final DateTime windowStart;
  final DateTime windowEnd;
  final int screenOnOffCount;
  final Map<String, int> appOpenCounts;
  final Map<String, int> appDurations;

  const UsageSnapshot({
    required this.windowStart,
    required this.windowEnd,
    required this.screenOnOffCount,
    required this.appOpenCounts,
    required this.appDurations,
  });
}

/// Sugestão gerada pelo motor de regras.
class SuggestionData {
  final String id;
  final String message;
  final String explanation;
  final String ruleId;
  final String language;

  const SuggestionData({
    required this.id,
    required this.message,
    required this.explanation,
    required this.ruleId,
    required this.language,
  });
}

/// Motor de regras comportamentais (stub).
class RuleEngine {
  SuggestionData? evaluate(UsageSnapshot snapshot, {
    required String language,
    required bool isSnoozed,
    required int dailyCount,
    required int maxPerDay,
  }) {
    if (isSnoozed || dailyCount >= maxPerDay) return null;
    // TODO: implementar regras A/B/C conforme spec
    return null;
  }
}
