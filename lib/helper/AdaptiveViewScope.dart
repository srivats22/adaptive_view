import 'package:flutter/material.dart';

class AdaptiveViewScope extends InheritedNotifier<ValueNotifier<int?>> {
  AdaptiveViewScope({
    super.key,
    required super.child,
  }) : super(
    notifier: ValueNotifier<int?>(null),
  );

  static ValueNotifier<int?> of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AdaptiveViewScope>();
    if (scope == null) {
      throw FlutterError(
        'AdaptiveViewScope not found in widget tree. '
            'Make sure AdaptiveView is an ancestor of this widget.',
      );
    }
    return scope.notifier!;
  }

  static ValueNotifier<int?> maybeOf(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AdaptiveViewScope>();
    return scope?.notifier ?? ValueNotifier<int?>(null);
  }
}