import 'package:flutter/material.dart';

import 'login_bloc.dart';

class Provider extends InheritedWidget {
  final bloc = LoginBloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().bloc;
  }
}
