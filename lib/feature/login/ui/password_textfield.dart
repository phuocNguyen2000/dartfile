import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wcloud/generated/l10n.dart';

// ignore: must_be_immutable
class PasswordTextField extends StatefulWidget {
  final passwordController = TextEditingController();
  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    widget.passwordController.text = 'admin';
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: TextField(
        cursorColor: Color(0xff00ce2d),
        obscureText: _isObscure,
        controller: widget.passwordController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            prefixIcon: Icon(Icons.vpn_key_outlined, color: Color(0xffD6D3DB)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff00ce2d), width: 2),
                borderRadius: BorderRadius.circular(24)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(24)),
            hintText: S.current.password_hint,
            hintStyle: TextStyle(color: Color(0xffD6D3DB)),
            suffixIcon: IconButton(
              icon: Icon(!_isObscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            )),
      ),
    );
  }
}
