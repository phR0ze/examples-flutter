import 'package:riverpod_annotation/riverpod_annotation.dart';
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
}
