import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'model.dart';
import 'state.dart';
import 'post_list.dart';

class GroupList extends HookConsumerWidget {
  const GroupList({
    super.key,
    required this.groups,
  });

  final List<PathItem> groups;

  @override
  Widget build(context, ref) {
    var group = useState(groups.isEmpty ? '' : groups[0].name);
    return groups.isEmpty
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
                      itemCount: groups.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () {
                            if (group.value != groups[index].name) {
                              group.value = groups[index].name;
                            }
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: groups[index].name == group.value
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
                                  groups[index].image,
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
                  group.value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20.0,
                      ),
                ),
              ),
              ref.watch(PostNotifierProvider(group.value)).when(
                    data: (value) => PostList(posts: value),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Please Retry'),
                          duration: const Duration(milliseconds: 1500),
                          width: MediaQuery.of(context).size.width / 4 * 3,
                          padding: const EdgeInsets.all(8.0),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return const SizedBox.shrink();
                    },
                  ),
            ],
          );
  }
}
