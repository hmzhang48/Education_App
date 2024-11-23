import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'state.dart';

class NewPost extends HookConsumerWidget {
  const NewPost({super.key});

  @override
  Widget build(context, ref) {
    final groupController = useTextEditingController();
    final titleController = useTextEditingController();
    final contentController = useTextEditingController();
    final picker = useMemoized(() => ImagePicker());
    final images = useState<List<XFile>>([]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'more',
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Group',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20.0,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: switch (ref.watch(PathNotifierProvider(true))) {
                AsyncData(:final value) => DropdownMenu(
                    controller: groupController,
                    initialSelection: value.isEmpty ? '' : value[0].name,
                    dropdownMenuEntries: value
                        .map(
                          (e) => DropdownMenuEntry(
                            value: e.name,
                            label: e.name,
                          ),
                        )
                        .toList(growable: false),
                    expandedInsets: EdgeInsets.zero,
                  ),
                AsyncError() => const Text('Error'),
                _ => DropdownMenu(
                    controller: groupController,
                    dropdownMenuEntries: [],
                    expandedInsets: EdgeInsets.zero,
                  ),
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Title',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20.0,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Content',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20.0,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextField(
                controller: contentController,
                minLines: 5,
                maxLines: 10,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Images',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20.0,
                    ),
              ),
            ),
            SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: images.value.length + 1,
                itemBuilder: (context, index) {
                  if (index == images.value.length) {
                    return DecoratedBox(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/placeholder.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: IconButton(
                            icon: const Icon(
                              Icons.add_a_photo_outlined,
                              size: 50,
                            ),
                            onPressed: () async {
                              var image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                images.value = [...images.value, image];
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.file(
                        File(images.value[index].path),
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
