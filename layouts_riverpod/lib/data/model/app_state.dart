import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:layouts/const.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({required int currentRoute, required double tileSize}) = _AppState;

  static AppState initial() => const AppState(currentRoute: 0, tileSize: Const.tileWidthDefault);
}
