import 'package:freezed_annotation/freezed_annotation.dart';

part 'configs.freezed.dart';
part 'configs.g.dart';

@freezed
class Configs with _$Configs {
  const factory Configs({
    required String currentProfileId,
  }) = _Configs;

  /// Provides a default constructor
  static defaults() => const Configs(currentProfileId: '');

  // Provides JSON code generation for toMap and fromMap methods
  factory Configs.fromJson(Map<String, Object?> json) => _$ConfigsFromJson(json);
}
