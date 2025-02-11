// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$commentRepositoryHash() => r'ba56e31ee16c6211088ff0acd36d7e7a31fab0dc';

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

abstract class _$CommentRepository
    extends BuildlessAutoDisposeAsyncNotifier<List<Comment>> {
  late final String bookId;

  FutureOr<List<Comment>> build(
    String bookId,
  );
}

/// See also [CommentRepository].
@ProviderFor(CommentRepository)
const commentRepositoryProvider = CommentRepositoryFamily();

/// See also [CommentRepository].
class CommentRepositoryFamily extends Family<AsyncValue<List<Comment>>> {
  /// See also [CommentRepository].
  const CommentRepositoryFamily();

  /// See also [CommentRepository].
  CommentRepositoryProvider call(
    String bookId,
  ) {
    return CommentRepositoryProvider(
      bookId,
    );
  }

  @override
  CommentRepositoryProvider getProviderOverride(
    covariant CommentRepositoryProvider provider,
  ) {
    return call(
      provider.bookId,
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
  String? get name => r'commentRepositoryProvider';
}

/// See also [CommentRepository].
class CommentRepositoryProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CommentRepository, List<Comment>> {
  /// See also [CommentRepository].
  CommentRepositoryProvider(
    String bookId,
  ) : this._internal(
          () => CommentRepository()..bookId = bookId,
          from: commentRepositoryProvider,
          name: r'commentRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$commentRepositoryHash,
          dependencies: CommentRepositoryFamily._dependencies,
          allTransitiveDependencies:
              CommentRepositoryFamily._allTransitiveDependencies,
          bookId: bookId,
        );

  CommentRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bookId,
  }) : super.internal();

  final String bookId;

  @override
  FutureOr<List<Comment>> runNotifierBuild(
    covariant CommentRepository notifier,
  ) {
    return notifier.build(
      bookId,
    );
  }

  @override
  Override overrideWith(CommentRepository Function() create) {
    return ProviderOverride(
      origin: this,
      override: CommentRepositoryProvider._internal(
        () => create()..bookId = bookId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bookId: bookId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CommentRepository, List<Comment>>
      createElement() {
    return _CommentRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommentRepositoryProvider && other.bookId == bookId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bookId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CommentRepositoryRef
    on AutoDisposeAsyncNotifierProviderRef<List<Comment>> {
  /// The parameter `bookId` of this provider.
  String get bookId;
}

class _CommentRepositoryProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CommentRepository,
        List<Comment>> with CommentRepositoryRef {
  _CommentRepositoryProviderElement(super.provider);

  @override
  String get bookId => (origin as CommentRepositoryProvider).bookId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
