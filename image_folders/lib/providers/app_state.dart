import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../const.dart';
import '../model/app_state.dart' as model;

// Generated riverpod code
part 'app_state.g.dart';

@Riverpod(keepAlive: true)
class AppState extends _$AppState {
  // Initial state
  @override
  model.AppState build() {
    return model.AppState.initial();
  }

  // Set the current route
  void setCurrentRoute(int value) {
    state = state.copyWith(currentRoute: value);
  }

  /// Zoom in on the tile size and save it to the database
  void zoomInSubTile() {
    state = state.copyWith(subTileSize: state.subTileSize + Const.tileSizeInc);
  }

  /// Zoom out on the tile size and save it to the database
  void zoomOutSubTile() {
    if (state.subTileSize - Const.tileSizeInc > Const.tileWidthMin) {
      state = state.copyWith(subTileSize: state.subTileSize - Const.tileSizeInc);
    }
  }

  /// Zoom in on the tile size and save it to the database
  void zoomInTopTile() {
    state = state.copyWith(topTileSize: state.topTileSize + Const.tileSizeInc);
  }

  /// Zoom out on the tile size and save it to the database
  void zoomOutTopTile() {
    if (state.topTileSize - Const.tileSizeInc > Const.tileWidthMin) {
      state = state.copyWith(topTileSize: state.topTileSize - Const.tileSizeInc);
    }
  }
}
