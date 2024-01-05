// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppState {
  int get currentRoute => throw _privateConstructorUsedError;
  double get tileSize => throw _privateConstructorUsedError;
  double get topLevelTileSize => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call({int currentRoute, double tileSize, double topLevelTileSize});
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentRoute = null,
    Object? tileSize = null,
    Object? topLevelTileSize = null,
  }) {
    return _then(_value.copyWith(
      currentRoute: null == currentRoute
          ? _value.currentRoute
          : currentRoute // ignore: cast_nullable_to_non_nullable
              as int,
      tileSize: null == tileSize
          ? _value.tileSize
          : tileSize // ignore: cast_nullable_to_non_nullable
              as double,
      topLevelTileSize: null == topLevelTileSize
          ? _value.topLevelTileSize
          : topLevelTileSize // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppStateImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppStateImplCopyWith(
          _$AppStateImpl value, $Res Function(_$AppStateImpl) then) =
      __$$AppStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int currentRoute, double tileSize, double topLevelTileSize});
}

/// @nodoc
class __$$AppStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppStateImpl>
    implements _$$AppStateImplCopyWith<$Res> {
  __$$AppStateImplCopyWithImpl(
      _$AppStateImpl _value, $Res Function(_$AppStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentRoute = null,
    Object? tileSize = null,
    Object? topLevelTileSize = null,
  }) {
    return _then(_$AppStateImpl(
      currentRoute: null == currentRoute
          ? _value.currentRoute
          : currentRoute // ignore: cast_nullable_to_non_nullable
              as int,
      tileSize: null == tileSize
          ? _value.tileSize
          : tileSize // ignore: cast_nullable_to_non_nullable
              as double,
      topLevelTileSize: null == topLevelTileSize
          ? _value.topLevelTileSize
          : topLevelTileSize // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$AppStateImpl implements _AppState {
  const _$AppStateImpl(
      {required this.currentRoute,
      required this.tileSize,
      required this.topLevelTileSize});

  @override
  final int currentRoute;
  @override
  final double tileSize;
  @override
  final double topLevelTileSize;

  @override
  String toString() {
    return 'AppState(currentRoute: $currentRoute, tileSize: $tileSize, topLevelTileSize: $topLevelTileSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateImpl &&
            (identical(other.currentRoute, currentRoute) ||
                other.currentRoute == currentRoute) &&
            (identical(other.tileSize, tileSize) ||
                other.tileSize == tileSize) &&
            (identical(other.topLevelTileSize, topLevelTileSize) ||
                other.topLevelTileSize == topLevelTileSize));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, currentRoute, tileSize, topLevelTileSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      __$$AppStateImplCopyWithImpl<_$AppStateImpl>(this, _$identity);
}

abstract class _AppState implements AppState {
  const factory _AppState(
      {required final int currentRoute,
      required final double tileSize,
      required final double topLevelTileSize}) = _$AppStateImpl;

  @override
  int get currentRoute;
  @override
  double get tileSize;
  @override
  double get topLevelTileSize;
  @override
  @JsonKey(ignore: true)
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
