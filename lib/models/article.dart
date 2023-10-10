import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../utils/type_defs.dart';

//TODO seperate class types for internet and non internet articles.
class Article {
  final String authorId;
  final String title;
  final String exciteLine;
  final Locale locale;
  final DateTime datePosted;
  final String? url;
  final String? content;
  Article({
    required this.authorId,
    required this.title,
    this.exciteLine = "Hey Check This Out!",
    required this.locale,
    required this.datePosted,
    this.url,
    this.content,
  });

  Article copyWith({
    String? authorId,
    String? title,
    String? exciteLine,
    Locale? locale,
    DateTime? datePosted,
    ValueGetter<String?>? url,
    ValueGetter<String?>? content,
  }) {
    return Article(
      authorId: authorId ?? this.authorId,
      title: title ?? this.title,
      exciteLine: exciteLine ?? this.exciteLine,
      locale: locale ?? this.locale,
      datePosted: datePosted ?? this.datePosted,
      url: url != null ? url() : this.url,
      content: content != null ? content() : this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'authorId': authorId,
      'title': title,
      'exciteLine': exciteLine,
      'locale': locale.index,
      'datePosted': datePosted.millisecondsSinceEpoch,
      'url': url,
      'content': content,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      authorId: map['authorId'] ?? '',
      title: map['title'] ?? '',
      exciteLine: map['exciteLine'] ?? '',
      locale: Locale.values.elementAt(map['locale']),
      datePosted: DateTime.fromMillisecondsSinceEpoch(map['datePosted']),
      url: map['url'],
      content: map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Article(authorId: $authorId, title: $title, exciteLine: $exciteLine, locale: $locale, datePosted: $datePosted, url: $url, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Article &&
        other.authorId == authorId &&
        other.title == title &&
        other.exciteLine == exciteLine &&
        other.locale == locale &&
        other.datePosted == datePosted &&
        other.url == url &&
        other.content == content;
  }

  @override
  int get hashCode {
    return authorId.hashCode ^
        title.hashCode ^
        exciteLine.hashCode ^
        locale.hashCode ^
        datePosted.hashCode ^
        url.hashCode ^
        content.hashCode;
  }
}
