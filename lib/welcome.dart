import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Welcome extends HookWidget {
  const Welcome({super.key});

  @override
  Widget build(context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final pageController = usePageController();
    final tabController = useTabController(initialLength: 3);

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              tabController.index = index;
            },
            children: [
              Center(
                child: Text(
                  'Welcome\nSelf-learners!',
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge,
                ),
              ),
              Center(
                child: Text(
                  'Personalized and Optimized\nLearning Path\nfor you',
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge,
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Center(
                    child: Text(
                      'Let\'s start!',
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: FilledButton.tonal(
                            onPressed: () => context.goNamed(
                              'Sign',
                              queryParameters: {'create': 'true'},
                            ),
                            child: const Text('Sign up'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: FilledButton(
                            onPressed: () => context.goNamed(
                              'Sign',
                              queryParameters: {'create': 'false'},
                            ),
                            child: const Text('Sign in'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TabPageSelector(
              controller: tabController,
              color: colorScheme.surface,
              selectedColor: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
