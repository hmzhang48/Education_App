import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'model.dart';

class QuestionList extends HookWidget {
  final List<QuestionItem> questions;
  final String id;

  const QuestionList({
    super.key,
    required this.questions,
    required this.id,
  });

  @override
  Widget build(context) {
    var right = useMemoized(() => {for (var e in questions) e.title: e.answer});
    var answer = useState<Map<String, String>>({});
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      itemCount: questions.length + 1,
      itemBuilder: (context, index) {
        if (index == questions.length) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: FilledButton(
                  child: const Text('Finish'),
                  onPressed: () {
                    var score = 0;
                    answer.value.forEach((k, v) {
                      if (v == right[k]) {
                        score += 10;
                      }
                    });
                    context.goNamed(
                      'Result',
                      pathParameters: {'id': id},
                      extra: score,
                    );
                  },
                ),
              ),
            ],
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(child: Text((index + 1).toString())),
                ),
                Expanded(
                  child: Text(
                    questions[index].title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 16.0),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      questions[index].description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 15.0),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Image.network(questions[index].image),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(questions[index].question,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 15.0)),
                  ),
                ),
              ],
            ),
            ...questions[index].choices.map(
                  (choice) => RadioListTile(
                    title: Text(choice),
                    value: choice,
                    groupValue: answer.value[questions[index].title],
                    onChanged: (value) {
                      if (answer.value[questions[index].title] != value) {
                        answer.value = {
                          ...answer.value,
                          questions[index].title: value!
                        };
                      }
                    },
                  ),
                )
          ],
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
