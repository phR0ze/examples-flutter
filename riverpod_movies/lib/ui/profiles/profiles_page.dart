import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../providers/config.dart';
import '../../data/models/exports.dart' as models;
import 'add_profile_button.dart';
import 'profile_tile.dart';

class ProfilesPage extends ConsumerWidget {
  const ProfilesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configState = ref.watch(configProvider);
    //final profiles = ref.read(configsProvider);
    final screenSize = MediaQuery.of(context).size;
    final profiles = [
      const models.Profile(id: '1', name: 'Bob Marley'),
      const models.Profile(id: '2', name: 'Children'),
      const models.Profile(id: '3', name: 'Rubarb'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile selection'),
      ),
      body: configState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (config) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: (screenSize.width - 32.0) / 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.75,
              ),

              // Profiles plus the add button at the end
              itemCount: profiles.length + 1,
              itemBuilder: (context, index) {
                // For actual profiles, return a ProfileTile
                if (index < profiles.length) {
                  final profile = profiles[index];

                  return ProfileTile(
                    profile: profile,
                    selected: config.currentProfileId == profile.id,
                    onPressed: () {
                      ref.read(configProvider.notifier).updateCurrentProfileId(profile.id);
                      print('profile tile pressed');
                    },
                  );
                }
                // For the last item, return an AddProfileButton
                return AddProfileButton(
                  onPressed: () => const Placeholder(),
                );
              },
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
