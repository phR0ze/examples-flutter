import 'package:freezed_annotation/freezed_annotation.dart';

part 'person.freezed.dart';

// Provides JSON code generation for toMap and fromMap methods
part 'person.g.dart';

@freezed
class Person with _$Person {
  const factory Person({
    required String firstName,
    required String lastName,
    required int age,
  }) = _Person;

  // Provides JSON code generation for toMap and fromMap methods
  factory Person.fromJson(Map<String, Object?> json) => _$PersonFromJson(json);
}
