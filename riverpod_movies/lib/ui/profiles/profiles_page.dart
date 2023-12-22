import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../providers/exports.dart';
import '../../data/models/exports.dart' as models;
import 'add_profile_button.dart';
import 'profile_tile.dart';

class ProfilesPage extends ConsumerWidget {
  const ProfilesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final configState = ref.watch(configProvider);
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile selection'),
      ),
      body: profileState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (profiles) {
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
                    selected: false, //config.currentProfileId == profile.id,
                    onPressed: () {
                      ref.read(configProvider.notifier).updateCurrentProfileId(profile.id);
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
