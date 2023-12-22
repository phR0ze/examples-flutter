import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../providers/configs.dart';

class ProfilesPage extends ConsumerWidget {
  const ProfilesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(configsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile selection'),
      ),

      // Ignore config until it is loaded then use to select the correct profile on the page
      body: state.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (configs) {
          return Center(
            child: Text(configs.currentProfileId == ''
                ? 'No profile selected'
                : 'Selected profile: ${configs.currentProfileId}'),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
      ),
      // body: ProfilesGrid(
      //   profilesData: profilesData,
      //   onAddProfile: () => addProfile(context),
      //   onSelectedProfile: (profile) async {
      //     final dataStore = ref.read(dataStoreProvider);
      //     // the selected profile is an app-state variable.
      //     // changing this will cause a reload of AppStartupPage
      //     await dataStore.setSelectedProfile(profile);
      //   },
      // ),
    );
  }
}

// class ProfilesGrid extends StatelessWidget {
//   const ProfilesGrid(
//       {Key? key, required this.profilesData, this.onSelectedProfile, this.onAddProfile})
//       : super(key: key);
//   final ProfilesData profilesData;
//   final ValueChanged<Profile>? onSelectedProfile;
//   final VoidCallback? onAddProfile;

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final profiles = profilesData.sortedByName();
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: (screenSize.width - 32.0) / 3,
//           mainAxisSpacing: 10.0,
//           crossAxisSpacing: 10.0,
//           childAspectRatio: 0.75,
//         ),
//         itemCount: profiles.length + 1,
//         itemBuilder: (context, index) {
//           if (index < profiles.length) {
//             final profile = profiles[index];
//             return ProfileGridItem(
//               profile: profile,
//               selected: profilesData.selectedId == profile.id,
//               onPressed: () => onSelectedProfile?.call(profile),
//             );
//           }
//           return AddProfileButton(
//             onPressed: onAddProfile,
//           );
//         },
//       ),
//     );
//   }
// }
