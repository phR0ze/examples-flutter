import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'folder_page.dart';
import 'loading.dart';
import '../providers/folders.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(foldersProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Image folder example', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: SizedBox(
                height: 40,
                width: 130,
                child: FloatingActionButton.extended(
                  onPressed: () => ref.read(foldersProvider.notifier).getFolder(),
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
                  itemBuilder: (context, index) => GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Folder $index', style: Theme.of(context).textTheme.titleMedium),
                      Text(value[index], style: Theme.of(context).textTheme.bodyMedium),
                    ]),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FolderPage(path: value[index])));
                    },
                  ),
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
