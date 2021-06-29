import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wcloud/generated/l10n.dart';

// ignore: must_be_immutable
class UsernameTextField extends StatelessWidget {
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    usernameController.text = 'admin';
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: TextField(
        cursorColor: Color(0xff00ce2d),
        controller: usernameController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            prefixIcon:
                Icon(Icons.account_box_outlined, color: Color(0xffD6D3DB)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff00ce2d), width: 2),
                borderRadius: BorderRadius.circular(24)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(24)),
            hintText: S.current.user_name_hint,
            hintStyle: TextStyle(color: Color(0xffD6D3DB))),
      ),
    );
  }
}
