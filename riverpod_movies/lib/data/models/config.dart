import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

@freezed
class Config with _$Config {
  const factory Config({
    required String currentProfileId,
  }) = _Config;

  /// Provides a default constructor
  static defaults() => const Config(currentProfileId: 'Unknown');

  // Provides JSON code generation for toMap and fromMap methods
  factory Config.fromJson(Map<String, Object?> json) => _$ConfigFromJson(json);
}
