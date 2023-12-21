import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String id,
    required String name,
  }) = _Profile;

  // Provides JSON code generation for toMap and fromMap methods
  factory Profile.fromJson(Map<String, Object?> json) => _$ProfileFromJson(json);
}
