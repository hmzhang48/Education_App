import 'package:flutter/material.dart';

import 'model.dart';

class Post extends StatefulWidget {
  const Post({
    super.key,
    required this.source,
  });

  final PostItem source;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'more',
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shrinkWrap: true,
        itemCount: widget.source.comments.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    widget.source.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 20.0,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/${widget.source.user}.png',
                        width: 50,
                        height: 50,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.source.user,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 20.0,
                                    ),
                              ),
                              Text(
                                widget.source.timestamp
                                            .difference(DateTime.now())
                                            .inHours <
                                        1
                                    ? 'Just posted'
                                    : widget.source.timestamp.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 12.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_horiz),
                        tooltip: 'more',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                widget.source.image.isEmpty
                    ? const SizedBox.shrink()
                    : SizedBox(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: widget.source.image.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Image.asset(
                              'assets/${widget.source.image[index]}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                Text(
                  widget.source.content,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16.0,
                      ),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.thumb_up_outlined),
                          onPressed: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(widget.source.like.toString()),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.bookmark_border_outlined),
                          onPressed: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(widget.source.bookmark.toString()),
                        )
                      ],
                    ),
                  ],
                )
              ],
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/${widget.source.comments[index - 1].user}.png',
                        width: 50,
                        height: 50,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.source.comments[index - 1].user,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 20.0,
                                    ),
                              ),
                              Text(
                                widget.source.comments[index - 1].timestamp
                                            .difference(DateTime.now())
                                            .inHours <
                                        1
                                    ? 'Just posted'
                                    : widget.source.timestamp.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 12.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_horiz),
                        tooltip: 'more',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.source.comments[index - 1].content,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16.0,
                      ),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.thumb_up_outlined),
                          onPressed: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(widget.source.comments[index - 1].like
                              .toString()),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.bookmark_border_outlined),
                          onPressed: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(widget.source.comments[index - 1].bookmark
                              .toString()),
                        )
                      ],
                    ),
                  ],
                )
              ],
            );
          }
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_comment_outlined),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            showDragHandle: true,
            isScrollControlled: true,
            builder: (context) => Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(
                  20, 0, 20, MediaQuery.of(context).viewInsets.bottom + 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextField(
                      controller: _controller,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'New Comment',
                        border: OutlineInputBorder(),
                      ),
                      autofocus: true,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton(
                        onPressed: () {},
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
