import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String? user;
  final DateTime? timestamp;
  final String header;
  final String content;
  final String image;
  final int? like;
  final int? bookmark;
  final int? comments;
  final void Function() onTap;

  const CardItem({
    super.key,
    this.user,
    this.timestamp,
    required this.header,
    required this.content,
    required this.image,
    this.like,
    this.bookmark,
    this.comments,
    required this.onTap,
  });

  @override
  Widget build(context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            user == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/$user.png',
                          width: 50,
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user!,
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
                                timestamp!.difference(DateTime.now()).inHours <
                                        1
                                    ? 'Just posted'
                                    : timestamp.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 12.0,
                                    ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  header,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16.0,
                      ),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5.0),
                child: Text(
                  content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15.0,
                      ),
                ),
              ),
              trailing: image == 'placeholder.png'
                  ? Image.asset(
                      'assets/$image',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
            ),
            comments == null
                ? const SizedBox.shrink()
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(),
                  ),
            comments == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.thumb_up_outlined),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(like.toString()),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.bookmark_border_outlined),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(bookmark.toString()),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(Icons.comment_outlined),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(comments.toString()),
                            )
                          ],
                        )
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
