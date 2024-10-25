import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class PathItem {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;

  final String name;
  final String job;
  final String description;
  final String image;
  bool learning;
  int learningTime;
  int totalTime;

  PathItem({
    required this.name,
    required this.job,
    required this.description,
    required this.image,
    this.learning = false,
    this.learningTime = 0,
    this.totalTime = 0,
  });

  factory PathItem.fromJson(Map<String, dynamic> json) =>
      _$PathItemFromJson(json);

  Map<String, dynamic> toJson() => _$PathItemToJson(this);
}

@JsonSerializable()
class CourseItem {
  final String name;
  final String path;
  final String description;

  CourseItem({
    required this.name,
    required this.path,
    required this.description,
  });

  factory CourseItem.fromJson(Map<String, dynamic> json) =>
      _$CourseItemFromJson(json);

  Map<String, dynamic> toJson() => _$CourseItemToJson(this);
}

@JsonSerializable()
class QuestionItem {
  final String title;
  final String path;
  final String description;
  final String image;
  final String question;
  final Set<String> choices;
  final String answer;

  QuestionItem({
    required this.title,
    required this.path,
    required this.description,
    required this.image,
    required this.question,
    required this.choices,
    required this.answer,
  });

  factory QuestionItem.fromJson(Map<String, dynamic> json) =>
      _$QuestionItemFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionItemToJson(this);
}

@JsonSerializable()
class LectureItem {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;

  final double rank;
  final String path;
  final String description;
  final String introduction;
  final String asset;
  final int totalTime;
  final int learningTime;
  final Map<int, String> notes;

  LectureItem({
    required this.rank,
    required this.path,
    required this.description,
    required this.introduction,
    required this.asset,
    required this.totalTime,
    this.learningTime = 0,
    this.notes = const {},
  });

  factory LectureItem.fromJson(Map<String, dynamic> json) =>
      _$LectureItemFromJson(json);

  Map<String, dynamic> toJson() => _$LectureItemToJson(this);
}

@JsonSerializable()
class PostItem {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;

  final String group;
  final String user;
  final String title;
  final String content;
  final List<String> image;
  final int like;
  final int bookmark;
  final DateTime timestamp;

  @JsonKey(toJson: commentsToJson)
  final List<CommentItem> comments;

  PostItem({
    required this.group,
    this.user = 'avatar',
    required this.title,
    required this.content,
    this.image = const ['placeholder.png'],
    this.like = 0,
    this.bookmark = 0,
    this.comments = const [],
  }) : timestamp = DateTime.now();

  factory PostItem.fromJson(Map<String, dynamic> json) =>
      _$PostItemFromJson(json);

  Map<String, dynamic> toJson() => _$PostItemToJson(this);

  static List<Map<String, dynamic>> commentsToJson(List<CommentItem> value) =>
      value.map((e) => e.toJson()).toList();
}

@JsonSerializable()
class CommentItem {
  final String user;
  final String content;
  final int like;
  final int bookmark;
  final DateTime timestamp;

  CommentItem({
    this.user = 'avatar',
    required this.content,
    this.like = 0,
    this.bookmark = 0,
  }) : timestamp = DateTime.now();

  factory CommentItem.fromJson(Map<String, dynamic> json) =>
      _$CommentItemFromJson(json);

  Map<String, dynamic> toJson() => _$CommentItemToJson(this);
}
