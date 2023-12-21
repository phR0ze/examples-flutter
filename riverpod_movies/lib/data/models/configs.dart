import 'package:freezed_annotation/freezed_annotation.dart';

part 'configs.freezed.dart';
part 'configs.g.dart';

@freezed
class Configs with _$Configs {
  const factory Configs({
    required String id,
    required String name,
  }) = _Configs;

  // Provides JSON code generation for toMap and fromMap methods
  factory Configs.fromJson(Map<String, Object?> json) => _$ConfigsFromJson(json);
}
