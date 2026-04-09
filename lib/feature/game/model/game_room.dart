import 'package:equatable/equatable.dart';

class GameRoom extends Equatable {
  final String id;
  final List<String> letters;
  final Map<String, int> scores;
  final Map<String, List<String>> usedWords;
  final List<String> globalUsedWords;
  final bool isActive;
  final bool isStarted;
  final int endTime;
  final int maxPlayers;
  final List<String> players;
  final DateTime? createdAt;
  final String lang;

  const GameRoom({
    required this.id,
    this.letters = const [],
    this.scores = const {},
    this.usedWords = const {},
    this.globalUsedWords = const [],
    this.isActive = true,
    this.isStarted = false,
    required this.endTime,
    required this.maxPlayers,
    this.players = const [],
    this.createdAt,
    required this.lang,
  });

  GameRoom copyWith({
    String? id,
    List<String>? letters,
    Map<String, int>? scores,
    Map<String, List<String>>? usedWords,
    List<String>? globalUsedWords,
    bool? isActive,
    bool? isStarted,
    int? endTime,
    int? maxPlayers,
    List<String>? players,
    DateTime? createdAt,
    String? lang,
  }) {
    return GameRoom(
      id: id ?? this.id,
      letters: letters ?? this.letters,
      scores: scores ?? this.scores,
      usedWords: usedWords ?? this.usedWords,
      globalUsedWords: globalUsedWords ?? this.globalUsedWords,
      isActive: isActive ?? this.isActive,
      isStarted: isStarted ?? this.isStarted,
      endTime: endTime ?? this.endTime,
      maxPlayers: maxPlayers ?? this.maxPlayers,
      players: players ?? this.players,
      createdAt: createdAt ?? this.createdAt,
      lang: lang ?? this.lang,
    );
  }

  factory GameRoom.fromJson(String id, Map<String, dynamic> json) {
    return GameRoom(
      id: id,
      letters: List<String>.from(json['letters'] ?? []),
      scores: Map<String, int>.from(json['scores'] ?? {}),
      usedWords: (json['usedWords'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, List<String>.from(value)),
          ) ??
          {},
      globalUsedWords: List<String>.from(json['globalUsedWords'] ?? []),
      isActive: json['isActive'] ?? true,
      isStarted: json['isStarted'] ?? false,
      endTime: json['endTime'] ?? 0,
      maxPlayers: json['maxPlayers'] ?? 0,
      players: List<String>.from(json['players'] ?? []),
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as dynamic).toDate()
          : null,
      lang: json['lang'] ?? 'en',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'letters': letters,
      'scores': scores,
      'usedWords': usedWords,
      'globalUsedWords': globalUsedWords,
      'isActive': isActive,
      'isStarted': isStarted,
      'endTime': endTime,
      'maxPlayers': maxPlayers,
      'players': players,
      if (createdAt != null) 'createdAt': createdAt,
      'lang': lang,
    };
  }

  @override
  List<Object?> get props => [
        id,
        letters,
        scores,
        usedWords,
        globalUsedWords,
        isActive,
        isStarted,
        endTime,
        maxPlayers,
        players,
        createdAt,
        lang,
      ];
}
