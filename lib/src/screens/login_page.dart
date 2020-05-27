import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPass = false;
  bool _isValidUsername = true;
  bool _isValidPassword = true;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(13.0),
              child: FlutterLogo(),
              width: 70.0,
              height: 70.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffd8d8d8),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'Hello 🐣\nWelcome Back',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'you@example.com',
                errorText: _isValidUsername ? null : 'Invalid username',
                labelText: 'USERNAME',
                labelStyle: TextStyle(fontSize: 15.0, letterSpacing: 0.7),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                TextField(
                  controller: _passwordController,
                  obscureText: !_showPass,
                  decoration: InputDecoration(
                    errorText: _isValidPassword ? null : 'Invalid password',
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(fontSize: 15.0, letterSpacing: 0.7),
                  ),
                ),
                GestureDetector(
                  onTap: onToggleShowPass,
                  child: Text(
                    _showPass ? 'HIDE' : 'SHOW',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: Text(
                  'SIGN IN',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.0,
                  ),
                ),
                color: Colors.blue[700],
                onPressed: onSignInClicked,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Color(0xff888888)),
                    children: <TextSpan>[
                      TextSpan(text: 'NEW USERS? '),
                      TextSpan(
                        text: 'SIGN UP',
                        style: TextStyle(color: Colors.blue[700]),
                      ),
                    ],
                  ),
                ),
                Text(
                  'FORGOT PASSWORD?',
                  style: TextStyle(color: Colors.blue[700]),
                ),
              ],
            ),
            SizedBox(
              height: 70.0,
            ),
          ],
        ),
      ),
    );
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void onSignInClicked() {
    setState(() {
      if (_usernameController.text.length < 6 ||
          !_usernameController.text.contains('@')) {
        _isValidUsername = false;
      } else {
        _isValidUsername = true;
      }

      if (_passwordController.text.length < 6) {
        _isValidPassword = false;
      } else {
        _isValidPassword = true;
      }

      if (_isValidUsername && _isValidPassword) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }
}