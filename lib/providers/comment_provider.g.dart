// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$commentProviderHash() => r'0aa71735960599709a5ebfc6181a119109d6492b';

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

abstract class _$CommentProvider
    extends BuildlessAutoDisposeAsyncNotifier<List<Comment>> {
  late final String bookId;

  FutureOr<List<Comment>> build(
    String bookId,
  );
}

/// See also [CommentProvider].
@ProviderFor(CommentProvider)
const commentProviderProvider = CommentProviderFamily();

/// See also [CommentProvider].
class CommentProviderFamily extends Family<AsyncValue<List<Comment>>> {
  /// See also [CommentProvider].
  const CommentProviderFamily();

  /// See also [CommentProvider].
  CommentProviderProvider call(
    String bookId,
  ) {
    return CommentProviderProvider(
      bookId,
    );
  }

  @override
  CommentProviderProvider getProviderOverride(
    covariant CommentProviderProvider provider,
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
  String? get name => r'commentProviderProvider';
}

/// See also [CommentProvider].
class CommentProviderProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CommentProvider, List<Comment>> {
  /// See also [CommentProvider].
  CommentProviderProvider(
    String bookId,
  ) : this._internal(
          () => CommentProvider()..bookId = bookId,
          from: commentProviderProvider,
          name: r'commentProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$commentProviderHash,
          dependencies: CommentProviderFamily._dependencies,
          allTransitiveDependencies:
              CommentProviderFamily._allTransitiveDependencies,
          bookId: bookId,
        );

  CommentProviderProvider._internal(
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
    covariant CommentProvider notifier,
  ) {
    return notifier.build(
      bookId,
    );
  }

  @override
  Override overrideWith(CommentProvider Function() create) {
    return ProviderOverride(
      origin: this,
      override: CommentProviderProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<CommentProvider, List<Comment>>
      createElement() {
    return _CommentProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommentProviderProvider && other.bookId == bookId;
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
mixin CommentProviderRef on AutoDisposeAsyncNotifierProviderRef<List<Comment>> {
  /// The parameter `bookId` of this provider.
  String get bookId;
}

class _CommentProviderProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CommentProvider,
        List<Comment>> with CommentProviderRef {
  _CommentProviderProviderElement(super.provider);

  @override
  String get bookId => (origin as CommentProviderProvider).bookId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
