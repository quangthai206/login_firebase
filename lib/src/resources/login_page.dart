import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loginfirebase/src/blocs/provider.dart';
import 'package:loginfirebase/src/resources/register_page.dart';
import '../blocs/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginBloc = Provider.of(context);

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 80.0,
              ),
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
                    onTap: loginBloc.toggleShowPass,
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
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ));
                            },
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
            ],
          ),
        ),
      ),
    );
  }

  Widget usernameField(AuthBloc loginBloc) {
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

  Widget passwordField(AuthBloc loginBloc) {
    return StreamBuilder(
      stream: loginBloc.password,
      builder: (context, snapshot) => TextField(
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

  Widget submitButton(AuthBloc loginBloc) {
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
              onPressed: snapshot.hasData
                  ? () {
                      loginBloc.submit(context);
                    }
                  : null,
            );
          }),
    );
  }
}
