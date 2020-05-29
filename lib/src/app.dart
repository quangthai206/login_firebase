import 'package:flutter/material.dart';
import 'package:loginfirebase/src/resources/login_page.dart';
import 'blocs/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}
