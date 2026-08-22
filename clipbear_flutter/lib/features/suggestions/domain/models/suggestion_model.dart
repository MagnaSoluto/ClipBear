import 'package:equatable/equatable.dart';

enum SuggestionType {
  reminder,
  productivity,
  wellness,
  learning,
  social,
  creative,
}

enum SuggestionStatus {
  pending,
  accepted,
  rejected,
  postponed,
}

class SuggestionModel extends Equatable {
  final String id;
  final SuggestionType type;
  final String title;
  final String description;
  final String? emoji;
  final String reason;
  final DateTime createdAt;
  final DateTime? respondedAt;
  final DateTime? postponedUntil;
  final SuggestionStatus status;

  const SuggestionModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    this.emoji,
    required this.reason,
    required this.createdAt,
    this.respondedAt,
    this.postponedUntil,
    this.status = SuggestionStatus.pending,
  });

  SuggestionModel copyWith({
    String? id,
    SuggestionType? type,
    String? title,
    String? description,
    String? emoji,
    String? reason,
    DateTime? createdAt,
    DateTime? respondedAt,
    DateTime? postponedUntil,
    SuggestionStatus? status,
  }) {
    return SuggestionModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      emoji: emoji ?? this.emoji,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
      respondedAt: respondedAt ?? this.respondedAt,
      postponedUntil: postponedUntil ?? this.postponedUntil,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'description': description,
      'emoji': emoji,
      'reason': reason,
      'createdAt': createdAt.toIso8601String(),
      'respondedAt': respondedAt?.toIso8601String(),
      'postponedUntil': postponedUntil?.toIso8601String(),
      'status': status.name,
    };
  }

  factory SuggestionModel.fromJson(Map<String, dynamic> json) {
    return SuggestionModel(
      id: json['id'] as String,
      type: SuggestionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => SuggestionType.productivity,
      ),
      title: json['title'] as String,
      description: json['description'] as String,
      emoji: json['emoji'] as String?,
      reason: json['reason'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      respondedAt: json['respondedAt'] != null
          ? DateTime.parse(json['respondedAt'] as String)
          : null,
      postponedUntil: json['postponedUntil'] != null
          ? DateTime.parse(json['postponedUntil'] as String)
          : null,
      status: SuggestionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => SuggestionStatus.pending,
      ),
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        description,
        emoji,
        reason,
        createdAt,
        respondedAt,
        postponedUntil,
        status,
      ];
}
