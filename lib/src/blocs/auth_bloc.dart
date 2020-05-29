import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginfirebase/src/firebase/firebase_auth.dart';
import 'package:loginfirebase/src/resources/home_page.dart';

import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc extends Validators {
  var _fireAuth = FireAuth();
  bool isPasswordShowing = false;

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nameController = StreamController<String>();
  final _phoneController = StreamController<String>();

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  Stream<String> get name => _nameController.stream;
  Stream<String> get phone => _phoneController.stream;

  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  void dispose() {
    _emailController.close();
    _passwordController.close();
    _nameController.close();
    _phoneController.close();
  }

  void toggleShowPass() {
    isPasswordShowing = !isPasswordShowing;
    if (_passwordController.value != null) {
      changePassword(_passwordController.value);
    } else {
      changePassword("");
    }
  }

  bool isValid(String name, String email, String pass, String phone) {
    if (name == null || name.length == 0) {
      _nameController.sink.addError("Enter name");
      return false;
    }
    _nameController.sink.add("");

    if (phone == null || phone.length == 0) {
      _phoneController.sink.addError("Enter phone number");
      return false;
    }
    _phoneController.sink.add("");

    if (email == null || email.length == 0 || !email.contains('@')) {
      changeEmail('');
      return false;
    }
    changeEmail(email);

    if (pass == null || pass.length < 4) {
      changePassword('');
      return false;
    }
    changePassword(pass);

    return true;
  }

  void signUp(String email, String pass, String phone, String name,
      Function onSuccess, Function(String) onError) {
    _fireAuth.signUp(email, pass, name, phone, onSuccess, onError);
  }

  void signIn(Function onSuccess, Function(String) onSignInError) {
    _fireAuth.signIn(_emailController.value, _passwordController.value,
        onSuccess, onSignInError);
  }
}
