import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wcloud/feature/login/ui/login_page.dart';

import '../../common/widget/loading_widget.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: RichText(
                  text: TextSpan(
                    text: 'V',
                    style: TextStyle(
                        color: Color(0xff00ce2d),
                        fontSize: 80,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'cloud',
                          style: TextStyle(color: Color(0xff0077cd))),
                    ],
                  ),
                ),
              ),
              // SpinKitRing(color: Color(0xff00ce2d), size: 50)
            ],
          ))
        ],
      ),
    );
  }
}
