import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/exports.dart' as models;
import '../../providers/profiles.dart';
import '../common/async_value.dart';

class AddProfilePage extends ConsumerStatefulWidget {
  const AddProfilePage({super.key});

  @override
  ConsumerState<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends ConsumerState<AddProfilePage> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    // Reading the profiles and handling the async value here allows
    // for the ref.read down below to not worry about data being loaded yet
    final profilesAsyncValue = ref.watch(profilesProvider);
    final controller = TextEditingController();

    return AsyncValueWidget<List<models.Profile>>(
      asyncValue: profilesAsyncValue,
      builder: (profiles) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Profile'),
            actions: [
              TextButton(
                onPressed: () {
                  var profileName = controller.value.text;
                  if (ref.read(profilesProvider.notifier).profileExists(profileName)) {
                    setState(() {
                      errorText = 'Profile "$profileName" already exists';
                    });
                  } else {
                    var profile = models.Profile(id: profileName, name: profileName);
                    ref.read(profilesProvider.notifier).putProfile(profile);
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(32.0),
            alignment: Alignment.center,
            child: TextField(
              autofocus: true,
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Profile Name',
                hintText: 'Enter a profile name',
                errorText: errorText,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        );
      },
    );
  }
}
