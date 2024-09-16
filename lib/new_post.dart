import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'data_provider.dart';
import 'data.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final _groupController = TextEditingController();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _picker = ImagePicker();
  final List<XFile> images = [];

  @override
  void dispose() {
    _groupController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataStore = DataProvider.of<DataStore>(context);

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
            FutureBuilder(
              future: dataStore.findPaths(true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: DropdownMenu(
                      controller: _groupController,
                      initialSelection:
                          snapshot.data!.isEmpty ? '' : snapshot.data![0].name,
                      dropdownMenuEntries: snapshot.data!
                          .map(
                            (e) => DropdownMenuEntry(
                              value: e.name,
                              label: e.name,
                            ),
                          )
                          .toList(growable: false),
                      expandedInsets: EdgeInsets.zero,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
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
                controller: _titleController,
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
                controller: _contentController,
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
                itemCount: images.length + 1,
                itemBuilder: (context, index) {
                  if (index == images.length) {
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
                              var image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                setState(() => images.add(image));
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
                        File(images[index].path),
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
