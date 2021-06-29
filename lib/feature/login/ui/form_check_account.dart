import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wcloud/common/route/routes.dart';
import 'package:wcloud/feature/login/bloc/index.dart';
import 'package:wcloud/feature/login/ui/password_textfield.dart';
import 'package:wcloud/feature/login/ui/username_textfield.dart';
import 'package:wcloud/feature/signin_signup/resources/auth_api_provider.dart';
import 'package:wcloud/generated/l10n.dart';

class FormCheckAccount extends StatelessWidget {
  UsernameTextField _usernameTextField = new UsernameTextField();
  PasswordTextField _passwordTextField = new PasswordTextField();
  String error = '';
  @override
  Widget build(BuildContext context) {
    void _onLoginPressed() {
      String _username = _usernameTextField.usernameController.text;
      String _password = _passwordTextField.passwordController.text;
      BlocProvider.of<LoginBloc>(context)
          .add(LoginButtonPressed(username: _username, password: _password));
    }

    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        switch (state.error) {
          case 'psycopg2.OperationalError':
            error = S.current.database_does_not_exist;
            break;
          case 'odoo.exceptions.AccessDenied':
            error = S.current.username_or_password_is_incorrect;
            break;
          default:
            error = state.error;
            break;
        }
      } else if (state is LoginSuccess) {
        Navigator.pushReplacementNamed(context, Routes.loading);
      } else {
        error = '';
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(width: 2, color: Colors.blue),
              borderRadius: BorderRadius.circular(24)),
          child: Column(children: <Widget>[
            _usernameTextField,
            _passwordTextField,
            AnimatedOpacity(
              opacity: error != '' ? 1.0 : 0.0,
              duration: Duration(milliseconds: 200),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.topLeft,
                child: Text(
                  error,
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ),
            state is LoginLoading
                ? CircularProgressIndicator()
                : Container(
                    width: double.infinity,
                    height: 65,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xff00ce2d),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24))),
                      // textColor: Colors.white,
                      // color: Colors.blue,
                      child: Text(
                        S.current.sign_in,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        _onLoginPressed();
                      },
                    ),
                  ),
          ]));
    }));
  }
}
