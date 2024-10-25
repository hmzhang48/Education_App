import 'package:flutter/material.dart';

class DataProvider<T> extends InheritedWidget {
  const DataProvider({
    super.key,
    required this.data,
    required super.child,
  });

  final T data;

  static T of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataProvider<T>>()!.data;
  }

  @override
  bool updateShouldNotify(DataProvider oldWidget) {
    return data != oldWidget.data;
  }
}
