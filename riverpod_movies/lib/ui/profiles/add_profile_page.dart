import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/exports.dart' as models;
import '../../providers/profiles.dart';
import '../async_value.dart';

class AddProfilePage extends ConsumerStatefulWidget {
  const AddProfilePage({super.key});

  @override
  ConsumerState<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends ConsumerState<AddProfilePage> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
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
                  if (ref.read(profilesProvider.notifier).profileExists(controller.value.text)) {
                    setState(() {
                      errorText = 'Profile already exists';
                    });
                  } else {
                    //Navigator.pop(context, controller.value.text);
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
