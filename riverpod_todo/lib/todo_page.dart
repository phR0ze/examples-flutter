import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'model/exports.dart' as model;
import 'providers/exports.dart';

class AddTodoPage extends ConsumerWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idController = TextEditingController();
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _inputField('ID', idController),
              _inputField('Title', titleController),
              _inputField('Description', descriptionController),
              ElevatedButton(
                  onPressed: () {
                    var todo = model.Todo(
                      id: idController.value.text,
                      title: titleController.value.text,
                      description: descriptionController.value.text,
                    );
                    ref.read(todoProvider.notifier).add(todo);

                    // Now pop the page to go back to the home page
                    Navigator.pop(context);
                  },
                  child: const Text('Add Todo')),
            ],
          ),
        ),
      ),
    );
  }
}

Column _inputField(String label, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
      const SizedBox(height: 8.0),
    ],
  );
}
