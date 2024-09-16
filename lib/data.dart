import 'package:sembast/sembast.dart';
import 'package:sembast/utils/value_utils.dart';

import 'model.dart';

class DataStore {
  final Database db;
  late final StoreRef<int, Map<String, dynamic>> _pathStore;
  late final StoreRef<int, Map<String, dynamic>> _courseStore;
  late final StoreRef<int, Map<String, dynamic>> _questionStore;
  late final StoreRef<int, Map<String, dynamic>> _lectureStore;
  late final StoreRef<int, Map<String, dynamic>> _postStore;

  DataStore(this.db)
      : _pathStore = intMapStoreFactory.store('paths'),
        _courseStore = intMapStoreFactory.store('courses'),
        _questionStore = intMapStoreFactory.store('questions'),
        _lectureStore = intMapStoreFactory.store('Lectures'),
        _postStore = intMapStoreFactory.store('Posts');

  Future init() async {
    await _pathStore.delete(db);
    await _courseStore.delete(db);
    await _questionStore.delete(db);
    await _lectureStore.delete(db);
    await _postStore.delete(db);
    await db.transaction((txn) async {
      for (var item in paths) {
        await _pathStore.add(txn, item.toJson());
      }
      for (var item in courses) {
        await _courseStore.add(txn, item.toJson());
      }
      for (var item in questions) {
        await _questionStore.add(txn, item.toJson());
      }
      for (var item in lectures) {
        await _lectureStore.add(txn, item.toJson());
      }
      for (var item in posts) {
        await _postStore.add(txn, item.toJson());
      }
    });
  }

  Future updatePath(int id, String key, dynamic value) async {
    var record = await _pathStore.record(id).get(db);
    if (record != null) {
      var cloneRecord = cloneMap(record);
      cloneRecord[key] = value;
      await _pathStore.record(id).update(db, cloneRecord);
    }
  }

  Future<List<PathItem>> findPaths([bool? learning]) async {
    Finder? finder;
    if (learning != null) {
      finder = Finder(
        filter: Filter.equals('learning', learning),
      );
    }
    final snapshots = await _pathStore.find(db, finder: finder);
    return snapshots
        .map((snapshot) => PathItem.fromJson(snapshot.value)..id = snapshot.key)
        .toList(growable: false);
  }

  Future<List<CourseItem>> findCourses(int id) async {
    var record = await _pathStore.record(id).get(db);
    final snapshots = await _courseStore.find(
      db,
      finder: Finder(
        filter: Filter.equals('path', record?['name']),
      ),
    );
    return snapshots
        .map((snapshot) => CourseItem.fromJson(snapshot.value))
        .toList(growable: false);
  }

  Future<List<QuestionItem>> findQuestions(int id) async {
    var record = await _pathStore.record(id).get(db);
    final snapshots = await _questionStore.find(
      db,
      finder: Finder(
        filter: Filter.equals('path', record?['name']),
      ),
    );
    return snapshots
        .map((snapshot) => QuestionItem.fromJson(snapshot.value))
        .toList(growable: false);
  }

  Future<List<LectureItem>> findLectures(int id) async {
    var record = await _pathStore.record(id).get(db);
    final snapshots = await _lectureStore.find(
      db,
      finder: Finder(
        filter: Filter.equals('path', record?['name']),
      ),
    );
    return snapshots
        .map((snapshot) =>
            LectureItem.fromJson(snapshot.value)..id = snapshot.key)
        .toList(growable: false);
  }

  Future updateLecture(int id, String key, int value) async {
    var record = await _lectureStore.record(id).get(db);
    if (record != null) {
      var cloneRecord = cloneMap(record);
      cloneRecord[key] = value;
      await _lectureStore.record(id).update(db, cloneRecord);
    }
  }

  Future updateNote(int id, Duration time, String value) async {
    var record = await _lectureStore.record(id).get(db);
    if (record != null) {
      var cloneRecord = cloneMap(record);
      (cloneRecord['notes'] as Map<Duration, String>)[time] = value;
      await _lectureStore.record(id).update(db, cloneRecord);
    }
  }

  Future<List<PostItem>> findPosts([String? group]) async {
    Finder? finder;
    if (group != null) {
      finder = Finder(
        filter: Filter.equals('group', group),
      );
    }
    final snapshots = await _postStore.find(db, finder: finder);
    return snapshots
        .map((snapshot) => PostItem.fromJson(snapshot.value)..id = snapshot.key)
        .toList(growable: false);
  }
}

var paths = [
  PathItem(
    name: 'Statistics',
    job: 'Data Analyst',
    description:
        'The collection, organization, analysis, interpretation, and presentation of data.',
    image: 'statistics.png',
  ),
  PathItem(
    name: 'Machine Learning',
    job: 'Data Engineer',
    description:
        'The development and study of statistical algorithms that can learn from data and generalize to unseen data, and thus perform tasks without explicit instructions.',
    image: 'machine_learning.png',
    totalTime: 153,
    learningTime: 35,
  ),
];

var courses = [
  CourseItem(
    name: 'Stanford CS229: Machine Learning',
    path: 'Machine Learning',
    description: 'Taught by Andrew Ng',
  ),
  CourseItem(
    name: 'Stanford CS230: Deep Learning',
    path: 'Machine Learning',
    description: 'Taught by Andrew Ng',
  ),
  CourseItem(
    name: 'Practical Deep Learning for Coders',
    path: 'Machine Learning',
    description: 'Taught by Jeremy Howard',
  ),
];

var questions = [
  QuestionItem(
    title: 'Predictive power',
    path: 'Machine Learning',
    description:
        'Supervised ML models are trained using datasets with labeled examples. The model learns how to predict the label from the features. However, not every feature in a dataset has predictive power. In some instances, only a few features act as predictors of the label. In the dataset below, use price as the label and the remaining columns as the features.',
    image: 'assets/predictive_power.png',
    question:
        'Which three features do you think are likely the greatest predictors for a car\'s price?',
    choices: {
      'Miles, gearbox, make_model.',
      'Color, height, make_model.',
      'Tire_size, wheel_base, year.',
      'Make_model, year, miles.'
    },
    answer: 'Make_model, year, miles.',
  ),
  QuestionItem(
    title: 'Supervised and unsupervised learning',
    path: 'Machine Learning',
    description:
        'Based on the problem, you\'ll use either a supervised or unsupervised approach. For example, if you know beforehand the value or category you want to predict, you\'d use supervised learning. However, if you wanted to learn if your dataset contains any segmentations or groupings of related examples, you\'d use unsupervised learning. Suppose you had a dataset of users for an online shopping website, and it contained the following columns:',
    image: 'assets/supervised_unsupervised.png',
    question:
        'If you wanted to understand the types of users that visit the site, would you use supervised or unsupervised learning?',
    choices: {
      'Unsupervised learning.',
      'Supervised learning because I\'m trying to predict which class a user belongs to.',
    },
    answer: 'Unsupervised learning.',
  ),
];

var lectures = [
  LectureItem(
      rank: 1.1,
      path: 'Machine Learning',
      description:
          'A broad introduction to machine learning and statistical pattern recognition.',
      introduction:
          'This course provides a broad introduction to machine learning and statistical pattern recognition. Learn about both supervised and unsupervised learning as well as learning theory, reinforcement learning and control. Explore recent applications of machine learning and design and develop algorithms for machines.\n\nAndrew Ng is an Adjunct Professor of Computer Science at Stanford University.\n\n0:00 Introduction\n05:21 Teaching team introductions\n06:42 Goals for the course and the state of machine learning across research and industry\n10:09 Prerequisites for the course\n11:53 Homework, and a note about the Stanford honor code\n16:57 Overview of the class project\n25:57 Questions\n',
      asset: 'machine_learning_1.1',
      totalTime: 75,
      learningTime: 35,
      notes: {
        0: 'A broad introduction to machine learning and statistical pattern recognition.',
      }),
  LectureItem(
    rank: 1.2,
    path: 'Machine Learning',
    description: 'Supervised learning, Linear Regression and Gradient Descent',
    introduction:
        'This lecture covers supervised learning and linear regression.\n\nAndrew Ng is an Adjunct Professor of Computer Science at Stanford University.\n\n00:00 Intro\n00:45 Motivate Linear Regression\n03:01 Supervised Learning\n04:44 Designing a Learning Algorithm\n08:27 Parameters of the learning algorithm\n14:44 Linear Regression Algorithm\n18:06 Gradient Descent\n33:01 Gradient Descent Algorithm\n42:34 Batch Gradient Descent\n44:56 Stochastic Gradient Descent\n',
    asset: 'machine_learning_1.2',
    totalTime: 78,
  ),
];

var posts = [
  PostItem(
    group: 'Machine Learning',
    title: 'The EU definition of AI is pointless',
    content:
        'Here is the definition of "AI system" from the recent AI act by EU:\n"AI system" means a machine-based system that is designed to operate with varying levels of autonomy and that may exhibit adaptiveness after deployment, and that, for explicit or implicit objectives, infers, from the input it receives, how to generate outputs such as predictions, content, recommendations, or decisions that can influence physical or virtual environments;\nWhen removed the examples, that are examples and thus not mandatory for a system to be identified as "AI", the definition sounds like this:\n"AI system" means a machine-based system that is designed to operate with varying levels of autonomy and that, for explicit or implicit objectives, infers, from the input it receives, how to generate outputs.\nNow, this definition could include any software developed since the first year\'s university course of basic programming.\nTo start the discussion, I note the following:\n"infer" may refer to a statistical domain, but it would be limited. Moreover the word "infer" is not "statistically infer": the latter is connected with uncertainty, confidence, etc, while the former is a method of reasoning (from Merriam-Webster Dictionary: "to derive as a conclusion from facts or premises").\nThe word "how" is also wrong: most AI systems don\'t decide how to generate output, they don\'t modify the algorithm while running.\n"Varying levels of autonomy" doesn\'t set a minimum level: what\'s the minimum autonomy needed by an AI system?',
    comments: [
      CommentItem(
        content:
            'I\'ve dived into AI legal definitions for my job, and they all cover pretty much all software when read literally. And I think that\'s about as good as possible - AI doesn\'t have any better technical definition.\nIt\'s trying legislate around an idea that isn\'t even fully formed.',
      )
    ],
  ),
];
