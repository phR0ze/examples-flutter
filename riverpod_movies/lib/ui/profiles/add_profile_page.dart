import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddProfilePage extends ConsumerWidget {
  const AddProfilePage({super.key});

  // Future<void> createProfile(BuildContext context, WidgetRef ref, String name) async {
  //   final model = ref.read(createProfileModelProvider.notifier);
  //   final success = await model.createProfile(name);
  //   if (success) {
  //     Navigator.of(context).pop();
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Profile'),
        actions: [
          TextButton(
            onPressed: () {},
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
        child: const TextField(
            // controller: controller,
            // decoration: InputDecoration(errorText: widget.errorText),
            // onSubmitted: widget.isLoading ? null : (value) => widget.onSubmit(value),
            ),
      ),
    );
  }
}
