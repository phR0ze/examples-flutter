import 'package:freezed_annotation/freezed_annotation.dart';
import '../const.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState(
      {required int currentRoute,
      required bool darkMode,
      required double subTileSize,
      required double topTileSize}) = _AppState;

  static AppState initial() => const AppState(
      currentRoute: 0,
      darkMode: true,
      subTileSize: Const.tileWidthDefault,
      topTileSize: Const.tileWidthDefault);
}
