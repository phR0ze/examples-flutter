import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../providers/tab_selection.dart';
import '../data/models/exports.dart' as models;
import 'favorites_page.dart';
import 'now_playing_page.dart';
import 'users_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tabSelection = ref.watch(tabSelectionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Demo'),
      ),
      body: () {
        // initializing: () => const Center(child: CircularProgressIndicator()),
        // needsProfile: () => ProfileSelectionPage(),
        switch (tabSelection) {
          case models.TabSelection.favorites:
            return const FavoritesPage();
          case models.TabSelection.nowPlaying:
            return const NowPlayingPage();
          case models.TabSelection.users:
            return const UsersPage();
        }
      }(),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

/// BottomNavigation will display the current tab selection and rebuild when the tab
/// selection changes using a riverpod dependency injected NotifierProvider.
class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tabSelection = ref.watch(tabSelectionProvider);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: tabSelection.index,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.movie),
          label: 'Now Playing',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favourites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profiles',
        ),
      ],
      onTap: (index) => ref.read(tabSelectionProvider.notifier).set(index),
    );
  }
}
