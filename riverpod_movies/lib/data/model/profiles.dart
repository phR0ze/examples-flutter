import 'package:freezed_annotation/freezed_annotation.dart';
import 'profile.dart';

part 'profiles.freezed.dart';
part 'profiles.g.dart';

@freezed
class Profiles with _$Profiles {
  const factory Profiles({
    required Map<String, Profile> profiles,
  }) = _Profiles;

  // Provides JSON code generation for toMap and fromMap methods
  factory Profiles.fromJson(Map<String, Object?> json) => _$ProfilesFromJson(json);
}
