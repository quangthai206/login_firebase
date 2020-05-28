import 'package:flutter/material.dart';
import 'package:loginfirebase/src/blocs/provider.dart';
import '../blocs/login_bloc.dart';

class LoginPage extends StatelessWidget {
  final _passwordController = TextEditingController();

  void dispose() {
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = Provider.of(context);

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
            usernameField(loginBloc),
            SizedBox(
              height: 20.0,
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                passwordField(loginBloc),
                GestureDetector(
                  onTap: () {
                    loginBloc.toggleShowPass(_passwordController.text);
                  },
                  child: StreamBuilder(
                    stream: loginBloc.password,
                    builder: (context, snapshot) => Text(
                      loginBloc.isPasswordShowing ? 'HIDE' : 'SHOW',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            submitButton(loginBloc),
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
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget usernameField(LoginBloc loginBloc) {
    return StreamBuilder(
      stream: loginBloc.email,
      builder: (context, snapshot) => TextField(
        keyboardType: TextInputType.emailAddress,
        onChanged: loginBloc.changeEmail,
        decoration: InputDecoration(
          hintText: 'you@example.com',
          errorText: snapshot.error,
          labelText: 'USERNAME',
          labelStyle: TextStyle(fontSize: 15.0, letterSpacing: 0.7),
        ),
      ),
    );
  }

  Widget passwordField(LoginBloc loginBloc) {
    return StreamBuilder(
      stream: loginBloc.password,
      builder: (context, snapshot) => TextField(
        controller: _passwordController,
        onChanged: loginBloc.changePassword,
        obscureText: !loginBloc.isPasswordShowing,
        decoration: InputDecoration(
          errorText: snapshot.error,
          labelText: 'PASSWORD',
          labelStyle: TextStyle(fontSize: 15.0, letterSpacing: 0.7),
        ),
      ),
    );
  }

  Widget submitButton(LoginBloc loginBloc) {
    return Container(
      width: double.infinity,
      child: StreamBuilder(
          stream: loginBloc.submitValid,
          builder: (context, snapshot) {
            return RaisedButton(
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
              onPressed: snapshot.hasError ? null : () {},
            );
          }),
    );
  }
}
