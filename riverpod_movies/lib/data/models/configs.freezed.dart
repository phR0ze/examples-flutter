// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'configs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Configs _$ConfigsFromJson(Map<String, dynamic> json) {
  return _Configs.fromJson(json);
}

/// @nodoc
mixin _$Configs {
  String get currentProfileId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigsCopyWith<Configs> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigsCopyWith<$Res> {
  factory $ConfigsCopyWith(Configs value, $Res Function(Configs) then) =
      _$ConfigsCopyWithImpl<$Res, Configs>;
  @useResult
  $Res call({String currentProfileId});
}

/// @nodoc
class _$ConfigsCopyWithImpl<$Res, $Val extends Configs>
    implements $ConfigsCopyWith<$Res> {
  _$ConfigsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentProfileId = null,
  }) {
    return _then(_value.copyWith(
      currentProfileId: null == currentProfileId
          ? _value.currentProfileId
          : currentProfileId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfigsImplCopyWith<$Res> implements $ConfigsCopyWith<$Res> {
  factory _$$ConfigsImplCopyWith(
          _$ConfigsImpl value, $Res Function(_$ConfigsImpl) then) =
      __$$ConfigsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String currentProfileId});
}

/// @nodoc
class __$$ConfigsImplCopyWithImpl<$Res>
    extends _$ConfigsCopyWithImpl<$Res, _$ConfigsImpl>
    implements _$$ConfigsImplCopyWith<$Res> {
  __$$ConfigsImplCopyWithImpl(
      _$ConfigsImpl _value, $Res Function(_$ConfigsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentProfileId = null,
  }) {
    return _then(_$ConfigsImpl(
      currentProfileId: null == currentProfileId
          ? _value.currentProfileId
          : currentProfileId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigsImpl implements _Configs {
  const _$ConfigsImpl({required this.currentProfileId});

  factory _$ConfigsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigsImplFromJson(json);

  @override
  final String currentProfileId;

  @override
  String toString() {
    return 'Configs(currentProfileId: $currentProfileId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigsImpl &&
            (identical(other.currentProfileId, currentProfileId) ||
                other.currentProfileId == currentProfileId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currentProfileId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigsImplCopyWith<_$ConfigsImpl> get copyWith =>
      __$$ConfigsImplCopyWithImpl<_$ConfigsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigsImplToJson(
      this,
    );
  }
}

abstract class _Configs implements Configs {
  const factory _Configs({required final String currentProfileId}) =
      _$ConfigsImpl;

  factory _Configs.fromJson(Map<String, dynamic> json) = _$ConfigsImpl.fromJson;

  @override
  String get currentProfileId;
  @override
  @JsonKey(ignore: true)
  _$$ConfigsImplCopyWith<_$ConfigsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}