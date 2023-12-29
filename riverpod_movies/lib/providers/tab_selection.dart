import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/model/tab_selection.dart' as model;

// Generated riverpod code
part 'tab_selection.g.dart';

// Defines a sync `tabSelectionProvider` Notifier for mutable state
@riverpod
class TabSelection extends _$TabSelection {
  // Initial state
  @override
  // Todo - change to nowPlaying?
  //models.TabSelection build() => models.TabSelection.nowPlaying;
  model.TabSelection build() => model.TabSelection.nowPlaying;

  // Update tab selection state
  set(int index) => state = model.TabSelection.values[index];
}
