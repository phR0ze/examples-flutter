import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
  }) = _User;

  // Provides JSON code generation for toMap and fromMap methods
  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
