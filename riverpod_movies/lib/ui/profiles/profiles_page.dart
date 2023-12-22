import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../providers/configs.dart';
import '../../data/models/exports.dart' as models;
import 'add_profile_button.dart';
import 'profile_tile.dart';

class ProfilesPage extends ConsumerWidget {
  const ProfilesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configState = ref.watch(configsProvider);
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

      // Ignore config until it is loaded then use to select the correct profile on the page
      // body: state.when(
      //   loading: () => const Center(
      //     child: CircularProgressIndicator(),
      //   ),
      //   data: (configs) {
      //     return Center(
      //       child: Text(configs.currentProfileId == ''
      //           ? 'No profile selected'
      //           : 'Selected profile: ${configs.currentProfileId}'),
      //     );
      //   },
      //   error: (error, stackTrace) => Center(
      //     child: Text('Error: $error'),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: (screenSize.width - 32.0) / 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.75,
          ),
          itemCount: profiles.length + 1,
          itemBuilder: (context, index) {
            if (index < profiles.length) {
              final profile = profiles[index];
              return ProfileTile(
                profile: profile,
                selected: false,
                onPressed: () {
                  print('profile tile pressed');
                },
              );
            }
            return AddProfileButton(
              onPressed: () => const Placeholder(),
            );
          },
        ),
      ),
    );
  }
}
