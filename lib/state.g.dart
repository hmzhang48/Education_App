// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$prefsHash() => r'95a3951d4c1c946e6282ab6d2f499cc990f86257';

/// See also [prefs].
@ProviderFor(prefs)
final prefsProvider = AutoDisposeProvider<SharedPreferencesAsync>.internal(
  prefs,
  name: r'prefsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$prefsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PrefsRef = AutoDisposeProviderRef<SharedPreferencesAsync>;
String _$authHash() => r'6c1b267345b0d72baa5c875edb18238a3871867c';

/// See also [auth].
@ProviderFor(auth)
final authProvider = AutoDisposeProvider<FirebaseAuth>.internal(
  auth,
  name: r'authProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRef = AutoDisposeProviderRef<FirebaseAuth>;
String _$courseHash() => r'17415ad470d4620fda54504dea6c891e0bdac6b6';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [course].
@ProviderFor(course)
const courseProvider = CourseFamily();

/// See also [course].
class CourseFamily extends Family<AsyncValue<List<CourseItem>>> {
  /// See also [course].
  const CourseFamily();

  /// See also [course].
  CourseProvider call(
    String id,
  ) {
    return CourseProvider(
      id,
    );
  }

  @override
  CourseProvider getProviderOverride(
    covariant CourseProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'courseProvider';
}

/// See also [course].
class CourseProvider extends AutoDisposeFutureProvider<List<CourseItem>> {
  /// See also [course].
  CourseProvider(
    String id,
  ) : this._internal(
          (ref) => course(
            ref as CourseRef,
            id,
          ),
          from: courseProvider,
          name: r'courseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseHash,
          dependencies: CourseFamily._dependencies,
          allTransitiveDependencies: CourseFamily._allTransitiveDependencies,
          id: id,
        );

  CourseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<List<CourseItem>> Function(CourseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseProvider._internal(
        (ref) => create(ref as CourseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CourseItem>> createElement() {
    return _CourseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CourseRef on AutoDisposeFutureProviderRef<List<CourseItem>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _CourseProviderElement
    extends AutoDisposeFutureProviderElement<List<CourseItem>> with CourseRef {
  _CourseProviderElement(super.provider);

  @override
  String get id => (origin as CourseProvider).id;
}

String _$questionHash() => r'ef4c39516d4867c85ec958ca05c6eb8b4f0c3c0b';

/// See also [question].
@ProviderFor(question)
const questionProvider = QuestionFamily();

/// See also [question].
class QuestionFamily extends Family<AsyncValue<List<QuestionItem>>> {
  /// See also [question].
  const QuestionFamily();

  /// See also [question].
  QuestionProvider call(
    String id,
  ) {
    return QuestionProvider(
      id,
    );
  }

  @override
  QuestionProvider getProviderOverride(
    covariant QuestionProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'questionProvider';
}

/// See also [question].
class QuestionProvider extends AutoDisposeFutureProvider<List<QuestionItem>> {
  /// See also [question].
  QuestionProvider(
    String id,
  ) : this._internal(
          (ref) => question(
            ref as QuestionRef,
            id,
          ),
          from: questionProvider,
          name: r'questionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$questionHash,
          dependencies: QuestionFamily._dependencies,
          allTransitiveDependencies: QuestionFamily._allTransitiveDependencies,
          id: id,
        );

  QuestionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<List<QuestionItem>> Function(QuestionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: QuestionProvider._internal(
        (ref) => create(ref as QuestionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<QuestionItem>> createElement() {
    return _QuestionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuestionProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin QuestionRef on AutoDisposeFutureProviderRef<List<QuestionItem>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _QuestionProviderElement
    extends AutoDisposeFutureProviderElement<List<QuestionItem>>
    with QuestionRef {
  _QuestionProviderElement(super.provider);

  @override
  String get id => (origin as QuestionProvider).id;
}

String _$pathNotifierHash() => r'727601a93693406f8f9f0b3d461099875541f5df';

abstract class _$PathNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<PathItem>> {
  late final bool? learning;

  FutureOr<List<PathItem>> build([
    bool? learning,
  ]);
}

/// See also [PathNotifier].
@ProviderFor(PathNotifier)
const pathNotifierProvider = PathNotifierFamily();

/// See also [PathNotifier].
class PathNotifierFamily extends Family<AsyncValue<List<PathItem>>> {
  /// See also [PathNotifier].
  const PathNotifierFamily();

  /// See also [PathNotifier].
  PathNotifierProvider call([
    bool? learning,
  ]) {
    return PathNotifierProvider(
      learning,
    );
  }

  @override
  PathNotifierProvider getProviderOverride(
    covariant PathNotifierProvider provider,
  ) {
    return call(
      provider.learning,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'pathNotifierProvider';
}

/// See also [PathNotifier].
class PathNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PathNotifier, List<PathItem>> {
  /// See also [PathNotifier].
  PathNotifierProvider([
    bool? learning,
  ]) : this._internal(
          () => PathNotifier()..learning = learning,
          from: pathNotifierProvider,
          name: r'pathNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pathNotifierHash,
          dependencies: PathNotifierFamily._dependencies,
          allTransitiveDependencies:
              PathNotifierFamily._allTransitiveDependencies,
          learning: learning,
        );

  PathNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.learning,
  }) : super.internal();

  final bool? learning;

  @override
  FutureOr<List<PathItem>> runNotifierBuild(
    covariant PathNotifier notifier,
  ) {
    return notifier.build(
      learning,
    );
  }

  @override
  Override overrideWith(PathNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: PathNotifierProvider._internal(
        () => create()..learning = learning,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        learning: learning,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PathNotifier, List<PathItem>>
      createElement() {
    return _PathNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PathNotifierProvider && other.learning == learning;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, learning.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PathNotifierRef on AutoDisposeAsyncNotifierProviderRef<List<PathItem>> {
  /// The parameter `learning` of this provider.
  bool? get learning;
}

class _PathNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PathNotifier,
        List<PathItem>> with PathNotifierRef {
  _PathNotifierProviderElement(super.provider);

  @override
  bool? get learning => (origin as PathNotifierProvider).learning;
}

String _$lectureNotifierHash() => r'5777fe55c3318ed1c15651fed3f47422e7f491a5';

abstract class _$LectureNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<LectureItem>> {
  late final String id;

  FutureOr<List<LectureItem>> build(
    String id,
  );
}

/// See also [LectureNotifier].
@ProviderFor(LectureNotifier)
const lectureNotifierProvider = LectureNotifierFamily();

/// See also [LectureNotifier].
class LectureNotifierFamily extends Family<AsyncValue<List<LectureItem>>> {
  /// See also [LectureNotifier].
  const LectureNotifierFamily();

  /// See also [LectureNotifier].
  LectureNotifierProvider call(
    String id,
  ) {
    return LectureNotifierProvider(
      id,
    );
  }

  @override
  LectureNotifierProvider getProviderOverride(
    covariant LectureNotifierProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'lectureNotifierProvider';
}

/// See also [LectureNotifier].
class LectureNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    LectureNotifier, List<LectureItem>> {
  /// See also [LectureNotifier].
  LectureNotifierProvider(
    String id,
  ) : this._internal(
          () => LectureNotifier()..id = id,
          from: lectureNotifierProvider,
          name: r'lectureNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$lectureNotifierHash,
          dependencies: LectureNotifierFamily._dependencies,
          allTransitiveDependencies:
              LectureNotifierFamily._allTransitiveDependencies,
          id: id,
        );

  LectureNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<List<LectureItem>> runNotifierBuild(
    covariant LectureNotifier notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(LectureNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: LectureNotifierProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<LectureNotifier, List<LectureItem>>
      createElement() {
    return _LectureNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LectureNotifierProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LectureNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<LectureItem>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _LectureNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<LectureNotifier,
        List<LectureItem>> with LectureNotifierRef {
  _LectureNotifierProviderElement(super.provider);

  @override
  String get id => (origin as LectureNotifierProvider).id;
}

String _$postNotifierHash() => r'3eb379d287dcdba3450a4dc077c1ed8a03d6d9c4';

abstract class _$PostNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<PostItem>> {
  late final String? group;

  FutureOr<List<PostItem>> build([
    String? group,
  ]);
}

/// See also [PostNotifier].
@ProviderFor(PostNotifier)
const postNotifierProvider = PostNotifierFamily();

/// See also [PostNotifier].
class PostNotifierFamily extends Family<AsyncValue<List<PostItem>>> {
  /// See also [PostNotifier].
  const PostNotifierFamily();

  /// See also [PostNotifier].
  PostNotifierProvider call([
    String? group,
  ]) {
    return PostNotifierProvider(
      group,
    );
  }

  @override
  PostNotifierProvider getProviderOverride(
    covariant PostNotifierProvider provider,
  ) {
    return call(
      provider.group,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'postNotifierProvider';
}

/// See also [PostNotifier].
class PostNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PostNotifier, List<PostItem>> {
  /// See also [PostNotifier].
  PostNotifierProvider([
    String? group,
  ]) : this._internal(
          () => PostNotifier()..group = group,
          from: postNotifierProvider,
          name: r'postNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postNotifierHash,
          dependencies: PostNotifierFamily._dependencies,
          allTransitiveDependencies:
              PostNotifierFamily._allTransitiveDependencies,
          group: group,
        );

  PostNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.group,
  }) : super.internal();

  final String? group;

  @override
  FutureOr<List<PostItem>> runNotifierBuild(
    covariant PostNotifier notifier,
  ) {
    return notifier.build(
      group,
    );
  }

  @override
  Override overrideWith(PostNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: PostNotifierProvider._internal(
        () => create()..group = group,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        group: group,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PostNotifier, List<PostItem>>
      createElement() {
    return _PostNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostNotifierProvider && other.group == group;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, group.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PostNotifierRef on AutoDisposeAsyncNotifierProviderRef<List<PostItem>> {
  /// The parameter `group` of this provider.
  String? get group;
}

class _PostNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PostNotifier,
        List<PostItem>> with PostNotifierRef {
  _PostNotifierProviderElement(super.provider);

  @override
  String? get group => (origin as PostNotifierProvider).group;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
