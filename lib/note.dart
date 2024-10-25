import 'package:flutter/material.dart';

class Note extends StatefulWidget {
  final String time;
  final String? note;

  const Note({
    super.key,
    required this.time,
    required this.note,
  });

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  bool isEditing = false;
  late String content;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    content = widget.note == null ? '' : widget.note!;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(
          20, 0, 20, MediaQuery.of(context).viewInsets.bottom + 10),
      child: isEditing
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => setState(() {
                        isEditing = false;
                      }),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    controller: _controller,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: widget.time.toString().split('.')[0],
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
                        setState(() {
                          isEditing = false;
                          content = _controller.text;
                        });
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
                        widget.time.toString().split('.')[0],
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 20.0,
                                ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => setState(() {
                        isEditing = true;
                        _controller.text = content;
                      }),
                      icon: Icon(
                        content == '' ? Icons.add : Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(content),
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
