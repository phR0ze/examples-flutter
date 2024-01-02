import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({required int currentRoute}) = _AppState;

  static AppState initial() => const AppState(currentRoute: 0);
}
