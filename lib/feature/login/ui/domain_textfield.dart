import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wcloud/feature/domain/bloc/domain_bloc.dart';
import 'package:wcloud/feature/domain/bloc/domain_event.dart';

// ignore: must_be_immutable
class DomainTextField extends StatelessWidget {
  final domainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    domainController.text = "demo.vuahethong.com";
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: TextField(
        cursorColor: Color(0xff00ce2d),
        controller: domainController,
        // onChanged: (value) {
        //   BlocProvider.of<DomainBloc>(context)
        //       .add(DomainButtonPressed(domain: value));
        // },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8),
            prefixIcon:
                Icon(Icons.cloud_circle_outlined, color: Color(0xffD6D3DB)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff00ce2d), width: 2),
                borderRadius: BorderRadius.circular(24)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(24)),
            hintText: 'yourcompany.com',
            hintStyle: TextStyle(color: Color(0xffD6D3DB))),
      ),
    );
  }
}
