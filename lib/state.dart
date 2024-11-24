import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'data.dart';
import 'model.dart';

part 'state.g.dart';

final _prefs = SharedPreferencesAsync();
final _auth = FirebaseAuth.instance;
final _db = FirebaseFirestore.instance;
final _bucket = FirebaseStorage.instance;

Future initState() async {
  _auth.useAuthEmulator('localhost', 9099);
  _db.useFirestoreEmulator('localhost', 8080);
  _bucket.useStorageEmulator('localhost', 9199);
  await initData(_db, _bucket);
  if (_auth.currentUser != null) {
    await _auth.signOut();
  }
  await _prefs.clear();
}

@riverpod
SharedPreferencesAsync prefs(Ref ref) => _prefs;

@riverpod
FirebaseAuth auth(Ref ref) => _auth;

@riverpod
class PathNotifier extends _$PathNotifier {
  @override
  Future<List<PathItem>> build([bool? learning]) async {
    return _db
        .collection('paths')
        .where('learning', isEqualTo: learning)
        .get()
        .then(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => PathItem.fromJson(doc.data())..id = doc.id)
              .toList(growable: false),
        );
  }

  Future<List<PathItem>> suggestion() async {
    return _db
        .collection('paths')
        .orderBy('name')
        .limit(3)
        .where('learning', isEqualTo: false)
        .get()
        .then(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => PathItem.fromJson(doc.data())..id = doc.id)
              .toList(growable: false),
        );
  }

  Future updatePath(String id, Map<String, dynamic> value) async {
    final pathRef = _db.collection('paths').doc(id);
    await pathRef.update(value);
    ref.invalidateSelf();
    await future;
  }
}

@riverpod
Future<List<CourseItem>> course(Ref ref, String id) async {
  final path = await _db
      .collection('paths')
      .doc(id)
      .get()
      .then((doc) => doc.data()?['name']);
  return _db.collection('courses').where('path', isEqualTo: path).get().then(
        (querySnapshot) => querySnapshot.docs
            .map((doc) => CourseItem.fromJson(doc.data()))
            .toList(growable: false),
      );
}

@riverpod
Future<List<QuestionItem>> question(Ref ref, String id) async {
  final path = await _db
      .collection('paths')
      .doc(id)
      .get()
      .then((doc) => doc.data()?['name']);
  return _db.collection('questions').where('path', isEqualTo: path).get().then(
        (querySnapshot) => querySnapshot.docs
            .map((doc) => QuestionItem.fromJson(doc.data()))
            .toList(growable: false),
      );
}

@riverpod
class LectureNotifier extends _$LectureNotifier {
  @override
  Future<List<LectureItem>> build(String id) async {
    final path = await _db
        .collection('paths')
        .doc(id)
        .get()
        .then((doc) => doc.data()?['name']);
    return _db.collection('lectures').where('path', isEqualTo: path).get().then(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => LectureItem.fromJson(doc.data())..id = doc.id)
              .toList(growable: false),
        );
  }

  Future updateLecture(String id, Map<String, dynamic> value) async {
    final lectureRef = _db.collection('lectures').doc(id);
    await lectureRef.update(value);
    ref.invalidateSelf();
    await future;
  }

  Future updateNote(String id, Duration key, String value) async {
    final lectureRef = _db.collection('lectures').doc(id);
    await lectureRef.update({'notes.${key.inSeconds}': value});
    ref.invalidateSelf();
    await future;
  }
}

@riverpod
class PostNotifier extends _$PostNotifier {
  @override
  Future<List<PostItem>> build([String? group]) async {
    return _db.collection('posts').where('group', isEqualTo: group).get().then(
          (value) => value.docs
              .map((doc) => PostItem.fromJson(doc.data())..id = doc.id)
              .toList(growable: false),
        );
  }

  Future<List<PostItem>> suggestion() async {
    return _db
        .collection('posts')
        .orderBy('like', descending: true)
        .limit(3)
        .get()
        .then(
          (value) => value.docs
              .map((doc) => PostItem.fromJson(doc.data())..id = doc.id)
              .toList(growable: false),
        );
  }
}
