import 'package:freezed_annotation/freezed_annotation.dart';
import '../const.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState(
      {required int currentRoute,
      required double tileSize,
      required double topLevelTileSize}) = _AppState;

  static AppState initial() => const AppState(
      currentRoute: 0, tileSize: Const.tileWidthDefault, topLevelTileSize: Const.tileWidthDefault);
}
