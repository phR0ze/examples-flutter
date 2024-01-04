import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'loading.dart';
import '../providers/folders.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final initDirectoryCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(foldersProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Folder selection example', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          // Align widgets to start on the left
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              width: 400,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Initial directory for dialog',
                ),
                controller: initDirectoryCtrl,
              ),
            ),

            // Add the action buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: SizedBox(
                height: 40,
                width: 130,
                child: FloatingActionButton.extended(
                  onPressed: () => ref.read(foldersProvider.notifier).getFolder(
                        initialDir: initDirectoryCtrl.text,
                      ),
                  label: const Text('Select folder'),
                  icon: const Icon(Icons.folder),
                ),
              ),
            ),

            const Divider(),

            // File selection results
            switch (asyncValue) {
              AsyncLoading() => const LoadingIndicator(),
              AsyncData(:final value) => ListView.separated(
                  shrinkWrap: true,
                  itemCount: value.length,
                  itemBuilder: (context, index) =>
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Folder $index', style: Theme.of(context).textTheme.titleMedium),
                    Text(value[index], style: Theme.of(context).textTheme.bodyMedium),
                  ]),
                  separatorBuilder: (context, index) => const Divider(),
                ),
              _ => const Text(''),
            },
          ],
        ),
      ),
    );
  }
}
