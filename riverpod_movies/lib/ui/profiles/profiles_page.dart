import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../providers/exports.dart';
import '../../data/models/exports.dart' as models;
import '../async_value.dart';
import 'add_profile_button.dart';
import 'profile_tile.dart';

class ProfilesPage extends ConsumerWidget {
  const ProfilesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final configAsyncValue = ref.watch(configProvider);
    final profileAsyncValue = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile selection'),
      ),
      body: AsyncValueWidget<List<models.Profile>>(
        asyncValue: profileAsyncValue,
        builder: (profiles) {
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
                    selected: configAsyncValue.value != null
                        ? configAsyncValue.value!.currentProfileId == profile.id
                        : false,
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
      ),
    );
  }
}
