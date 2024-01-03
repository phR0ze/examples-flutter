import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../const.dart';
import '../data/model/app_state.dart' as model;

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
  void zoomInTile() {
    state = state.copyWith(tileSize: state.tileSize + Const.tileSizeInc);
  }

  /// Zoom out on the tile size and save it to the database
  void zoomOutTile() {
    if (state.tileSize - Const.tileSizeInc > Const.tileWidthMin) {
      state = state.copyWith(tileSize: state.tileSize - Const.tileSizeInc);
    }
  }
}
