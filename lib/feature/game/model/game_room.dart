import 'package:equatable/equatable.dart';

/// App model representing a Game Room instance.
class GameRoom extends Equatable {
  /// Required default constructor
  const GameRoom({
    required this.id,
    required this.endTime,
    required this.maxPlayers,
    required this.lang,
    this.letters = const [],
    this.scores = const {},
    this.usedWords = const {},
    this.globalUsedWords = const [],
    this.isActive = true,
    this.isStarted = false,
    this.players = const [],
    this.createdAt,
  });

  /// Factory constructor to parse data from a Map
  factory GameRoom.fromJson(String id, Map<String, dynamic> json) {
    return GameRoom(
      id: id,
      letters: (json['letters'] as List<dynamic>?)
              ?.map((dynamic e) => e as String)
              .toList() ??
          const [],
      scores: (json['scores'] as Map<String, dynamic>?)?.map(
            (key, dynamic value) => MapEntry(key, value as int),
          ) ??
          const {},
      usedWords: (json['usedWords'] as Map<String, dynamic>?)?.map(
            (key, dynamic value) => MapEntry(
              key,
              (value as List<dynamic>).map((dynamic e) => e as String).toList(),
            ),
          ) ??
          const {},
      globalUsedWords: (json['globalUsedWords'] as List<dynamic>?)
              ?.map((dynamic e) => e as String)
              .toList() ??
          const [],
      isActive: (json['isActive'] as bool?) ?? true,
      isStarted: (json['isStarted'] as bool?) ?? false,
      endTime: (json['endTime'] as num?)?.toInt() ?? 0,
      maxPlayers: (json['maxPlayers'] as num?)?.toInt() ?? 0,
      players: (json['players'] as List<dynamic>?)
              ?.map((dynamic e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as dynamic).toDate() as DateTime
          : null,
      lang: (json['lang'] as String?) ?? 'en',
    );
  }

  /// The unique identifier of the game room.
  final String id;

  /// The list of letters available in this room.
  final List<String> letters;

  /// The scores mapped by player names.
  final Map<String, int> scores;

  /// The correctly guessed words mapped by player names.
  final Map<String, List<String>> usedWords;

  /// The correctly guessed words used across the room globally.
  final List<String> globalUsedWords;

  /// Whether the room is currently active.
  final bool isActive;

  /// Whether the game sequence has started.
  final bool isStarted;

  /// The time (in ms) when the game ends.
  final int endTime;

  /// Maximum allowed players in the room.
  final int maxPlayers;

  /// Valid participants connected to the room.
  final List<String> players;

  /// Game room creation timestamp.
  final DateTime? createdAt;

  /// The language specified for this room.
  final String lang;

  /// Creates a new object with the specified values.
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
      endTime: endTime ?? this.endTime,
      maxPlayers: maxPlayers ?? this.maxPlayers,
      lang: lang ?? this.lang,
      letters: letters ?? this.letters,
      scores: scores ?? this.scores,
      usedWords: usedWords ?? this.usedWords,
      globalUsedWords: globalUsedWords ?? this.globalUsedWords,
      isActive: isActive ?? this.isActive,
      isStarted: isStarted ?? this.isStarted,
      players: players ?? this.players,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Convert into valid Map instance.
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
