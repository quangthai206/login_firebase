import 'package:flutter/material.dart';

import 'auth_bloc.dart';

class Provider extends InheritedWidget {
  final bloc = AuthBloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static AuthBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().bloc;
  }
}
