import 'package:flutter/material.dart';

import 'data_provider.dart';
import 'data.dart';
import 'model.dart';
import 'post_list.dart';

class GroupList extends StatefulWidget {
  const GroupList({
    super.key,
    required this.groups,
  });

  final List<PathItem> groups;

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  late String group;

  @override
  void initState() {
    super.initState();
    group = widget.groups.isEmpty ? '' : widget.groups[0].name;
  }

  @override
  Widget build(BuildContext context) {
    final dataStore = DataProvider.of<DataStore>(context);
    return widget.groups.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                        offset: Offset(0.0, 1.0),
                        blurRadius: 3.0,
                      )
                    ],
                  ),
                  child: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20),
                      shrinkWrap: true,
                      itemCount: widget.groups.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () {
                            if (group != widget.groups[index].name) {
                              setState(() => group = widget.groups[index].name);
                            }
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: widget.groups[index].name == group
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context)
                                        .colorScheme
                                        .surfaceContainer,
                                width: 3.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipOval(
                                child: Image.network(
                                  widget.groups[index].image,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  group,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20.0,
                      ),
                ),
              ),
              FutureBuilder(
                future: dataStore.findPosts(group),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return PostList(posts: snapshot.data!);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )
            ],
          );
  }
}
