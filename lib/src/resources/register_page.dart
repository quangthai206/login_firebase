import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loginfirebase/src/blocs/auth_bloc.dart';
import 'package:loginfirebase/src/resources/dialog/loading_dialog.dart';
import 'package:loginfirebase/src/resources/dialog/msg_dialog.dart';
import 'package:loginfirebase/src/resources/home_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthBloc registerBloc = new AuthBloc();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xff3277D8),
        ),
        elevation: 0,
      ),
      body: Container(
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
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
                  height: 20.0,
                ),
                Text(
                  'Welcome buddy!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff333333),
                  ),
                ),
                Text(
                  'Signup with me in simple steps',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff606470),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                IntrinsicHeight(
                  child: StreamBuilder(
                      stream: registerBloc.name,
                      builder: (context, snapshot) {
                        return TextField(
                          controller: _nameController,
                          style: TextStyle(fontSize: 13, color: Colors.black),
                          decoration: InputDecoration(
                            errorText:
                                snapshot.hasError ? snapshot.error : null,
                            contentPadding: EdgeInsets.all(13.0),
                            labelText: 'Name',
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffCED0D2), width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 15.0,
                ),
                IntrinsicHeight(
                  child: StreamBuilder(
                      stream: registerBloc.phone,
                      builder: (context, snapshot) {
                        return TextField(
                          controller: _phoneController,
                          style: TextStyle(fontSize: 13, color: Colors.black),
                          decoration: InputDecoration(
                            errorText:
                                snapshot.hasError ? snapshot.error : null,
                            contentPadding: EdgeInsets.all(13.0),
                            labelText: 'Phone Number',
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffCED0D2), width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 15.0,
                ),
                IntrinsicHeight(
                  child: StreamBuilder(
                      stream: registerBloc.email,
                      builder: (context, snapshot) {
                        return TextField(
                          controller: _emailController,
                          style: TextStyle(fontSize: 13, color: Colors.black),
                          decoration: InputDecoration(
                            errorText:
                                snapshot.hasError ? snapshot.error : null,
                            contentPadding: EdgeInsets.all(13.0),
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffCED0D2), width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 15.0,
                ),
                IntrinsicHeight(
                  child: StreamBuilder<Object>(
                      stream: registerBloc.password,
                      builder: (context, snapshot) {
                        return TextField(
                          controller: _passController,
                          style: TextStyle(fontSize: 13, color: Colors.black),
                          decoration: InputDecoration(
                            errorText:
                                snapshot.hasError ? snapshot.error : null,
                            contentPadding: EdgeInsets.all(13.0),
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffCED0D2), width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: _onSignUpClicked,
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(color: Colors.white, letterSpacing: 1.0),
                    ),
                    color: Color(0xff3277D8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Already a User? ',
                      style: TextStyle(color: Color(0xff606470), fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            },
                          text: 'Login now',
                          style:
                              TextStyle(color: Color(0xff3277D8), fontSize: 16),
                        ),
                      ]),
                )
              ],
            ),
          )),
    );
  }

  _onSignUpClicked() {
    var isValid = registerBloc.isValid(_nameController.text,
        _emailController.text, _passController.text, _phoneController.text);
    if (isValid) {
      LoadingDialog.showLoadingDialog(context, 'Signing up...');
      registerBloc.signUp(_emailController.text, _passController.text,
          _phoneController.text, _nameController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Sign-up", msg);
        // show msg dialog
      });
    }
  }
}
