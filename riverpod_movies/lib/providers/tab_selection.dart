import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models/tab_selection.dart' as models;

// Generated riverpod code
part 'tab_selection.g.dart';

// Defines a sync `tabSelectionProvider` Notifier for mutable state
@riverpod
class TabSelection extends _$TabSelection {
  // Initial state
  @override
  models.TabSelection build() => models.TabSelection.nowPlaying;

  // Update tab selection state
  set(models.TabSelection selection) => state = selection;
}