// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$commentViewModelHash() => r'ffd6dfc78a007c577df817684d7e2c04c83c9373';

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

abstract class _$CommentViewModel
    extends BuildlessAutoDisposeAsyncNotifier<List<Comment>> {
  late final String bookId;

  FutureOr<List<Comment>> build(
    String bookId,
  );
}

/// See also [CommentViewModel].
@ProviderFor(CommentViewModel)
const commentViewModelProvider = CommentViewModelFamily();

/// See also [CommentViewModel].
class CommentViewModelFamily extends Family<AsyncValue<List<Comment>>> {
  /// See also [CommentViewModel].
  const CommentViewModelFamily();

  /// See also [CommentViewModel].
  CommentViewModelProvider call(
    String bookId,
  ) {
    return CommentViewModelProvider(
      bookId,
    );
  }

  @override
  CommentViewModelProvider getProviderOverride(
    covariant CommentViewModelProvider provider,
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
  String? get name => r'commentViewModelProvider';
}

/// See also [CommentViewModel].
class CommentViewModelProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CommentViewModel, List<Comment>> {
  /// See also [CommentViewModel].
  CommentViewModelProvider(
    String bookId,
  ) : this._internal(
          () => CommentViewModel()..bookId = bookId,
          from: commentViewModelProvider,
          name: r'commentViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$commentViewModelHash,
          dependencies: CommentViewModelFamily._dependencies,
          allTransitiveDependencies:
              CommentViewModelFamily._allTransitiveDependencies,
          bookId: bookId,
        );

  CommentViewModelProvider._internal(
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
    covariant CommentViewModel notifier,
  ) {
    return notifier.build(
      bookId,
    );
  }

  @override
  Override overrideWith(CommentViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: CommentViewModelProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<CommentViewModel, List<Comment>>
      createElement() {
    return _CommentViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommentViewModelProvider && other.bookId == bookId;
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
mixin CommentViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<List<Comment>> {
  /// The parameter `bookId` of this provider.
  String get bookId;
}

class _CommentViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CommentViewModel,
        List<Comment>> with CommentViewModelRef {
  _CommentViewModelProviderElement(super.provider);

  @override
  String get bookId => (origin as CommentViewModelProvider).bookId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
