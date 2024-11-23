import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Note extends HookWidget {
  final String time;
  final String? note;

  const Note({
    super.key,
    required this.time,
    required this.note,
  });

  @override
  Widget build(context) {
    var isEditing = useState(false);
    var content = useState(note ?? '');
    final controller = useTextEditingController();
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(
          20, 0, 20, MediaQuery.of(context).viewInsets.bottom + 10),
      child: isEditing.value
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => isEditing.value = false,
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    controller: controller,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: time.toString().split('.')[0],
                      border: const OutlineInputBorder(),
                    ),
                    autofocus: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                      onPressed: () {
                        isEditing.value = false;
                        content.value = controller.text;
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        time.toString().split('.')[0],
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 20.0,
                                ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        isEditing.value = true;
                        controller.text = content.value;
                      },
                      icon: Icon(
                        content.value == '' ? Icons.add : Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(content.value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Browse All Notes'),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
