import 'package:flutter/material.dart';
import 'package:starter/features/auth/model/user.dart';

class UserProvider extends InheritedWidget {
  const UserProvider({
    required this.user,
    required super.child,
    super.key,
  });

  final User user;

  static UserProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserProvider>();
  }

  static UserProvider of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No UserProvider found in context');

    return result!;
  }

  @override
  bool updateShouldNotify(UserProvider oldWidget) => user != oldWidget.user;
}
