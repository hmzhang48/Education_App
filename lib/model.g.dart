// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PathItem _$PathItemFromJson(Map<String, dynamic> json) => PathItem(
      name: json['name'] as String,
      job: json['job'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      learning: json['learning'] as bool? ?? false,
      learningTime: (json['learningTime'] as num?)?.toInt() ?? 0,
      totalTime: (json['totalTime'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PathItemToJson(PathItem instance) => <String, dynamic>{
      'name': instance.name,
      'job': instance.job,
      'description': instance.description,
      'image': instance.image,
      'learning': instance.learning,
      'learningTime': instance.learningTime,
      'totalTime': instance.totalTime,
    };

CourseItem _$CourseItemFromJson(Map<String, dynamic> json) => CourseItem(
      name: json['name'] as String,
      path: json['path'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$CourseItemToJson(CourseItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'description': instance.description,
    };

QuestionItem _$QuestionItemFromJson(Map<String, dynamic> json) => QuestionItem(
      title: json['title'] as String,
      path: json['path'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      question: json['question'] as String,
      choices:
          (json['choices'] as List<dynamic>).map((e) => e as String).toSet(),
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$QuestionItemToJson(QuestionItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'path': instance.path,
      'description': instance.description,
      'image': instance.image,
      'question': instance.question,
      'choices': instance.choices.toList(),
      'answer': instance.answer,
    };

LectureItem _$LectureItemFromJson(Map<String, dynamic> json) => LectureItem(
      rank: (json['rank'] as num).toDouble(),
      path: json['path'] as String,
      description: json['description'] as String,
      introduction: json['introduction'] as String,
      image: json['image'] as String,
      video: json['video'] as String,
      totalTime: (json['totalTime'] as num).toInt(),
      learningTime: (json['learningTime'] as num?)?.toInt() ?? 0,
      notes: (json['notes'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(int.parse(k), e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$LectureItemToJson(LectureItem instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'path': instance.path,
      'description': instance.description,
      'introduction': instance.introduction,
      'image': instance.image,
      'video': instance.video,
      'totalTime': instance.totalTime,
      'learningTime': instance.learningTime,
      'notes': instance.notes.map((k, e) => MapEntry(k.toString(), e)),
    };

PostItem _$PostItemFromJson(Map<String, dynamic> json) => PostItem(
      group: json['group'] as String,
      user: json['user'] as String? ?? 'avatar',
      title: json['title'] as String,
      content: json['content'] as String,
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const ['placeholder.png'],
      like: (json['like'] as num?)?.toInt() ?? 0,
      bookmark: (json['bookmark'] as num?)?.toInt() ?? 0,
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$PostItemToJson(PostItem instance) => <String, dynamic>{
      'group': instance.group,
      'user': instance.user,
      'title': instance.title,
      'content': instance.content,
      'image': instance.image,
      'like': instance.like,
      'bookmark': instance.bookmark,
      'timestamp': instance.timestamp.toIso8601String(),
      'comments': PostItem.commentsToJson(instance.comments),
    };

CommentItem _$CommentItemFromJson(Map<String, dynamic> json) => CommentItem(
      user: json['user'] as String? ?? 'avatar',
      content: json['content'] as String,
      like: (json['like'] as num?)?.toInt() ?? 0,
      bookmark: (json['bookmark'] as num?)?.toInt() ?? 0,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$CommentItemToJson(CommentItem instance) =>
    <String, dynamic>{
      'user': instance.user,
      'content': instance.content,
      'like': instance.like,
      'bookmark': instance.bookmark,
      'timestamp': instance.timestamp.toIso8601String(),
    };
