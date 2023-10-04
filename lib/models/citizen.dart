import 'dart:convert';

import 'package:flutter/foundation.dart';

//TODO potential property: color.

class Citizen {
  final String alias;
  final List<String> markedArticleIds;
  final String catchPhrase;
  final String uid;
  Citizen({
    required this.alias,
    required this.markedArticleIds,
    required this.catchPhrase,
    required this.uid,
  });

  Citizen copyWith({
    String? alias,
    List<String>? markedArticleIds,
    String? catchPhrase,
    String? uid,
  }) {
    return Citizen(
      alias: alias ?? this.alias,
      markedArticleIds: markedArticleIds ?? this.markedArticleIds,
      catchPhrase: catchPhrase ?? this.catchPhrase,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alias': alias,
      'markedArticleIds': markedArticleIds,
      'catchPhrase': catchPhrase,
      'uid': uid,
    };
  }

  factory Citizen.fromMap(Map<String, dynamic> map) {
    return Citizen(
      alias: map['alias'] ?? '',
      markedArticleIds: List<String>.from(map['markedArticleIds']),
      catchPhrase: map['catchPhrase'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Citizen.fromJson(String source) =>
      Citizen.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Citizen(alias: $alias, markedArticleIds: $markedArticleIds, catchPhrase: $catchPhrase, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Citizen &&
        other.alias == alias &&
        listEquals(other.markedArticleIds, markedArticleIds) &&
        other.catchPhrase == catchPhrase &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return alias.hashCode ^
        markedArticleIds.hashCode ^
        catchPhrase.hashCode ^
        uid.hashCode;
  }
}
