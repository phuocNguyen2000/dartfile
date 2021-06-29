import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:wcloud/common/route/routes.dart';

class LoadingWidget extends StatelessWidget {
  // static const svgPicture = 'assets/icons/vuahethong.svg';
  final Image svgPicture = Image.asset("assets/icons/w360s_logo.png");
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.pushReplacementNamed(context, Routes.home);
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(width: 200, height: 100, child: svgPicture),
            SpinKitCircle(
              color: Color(0xff00ce2d),
              size: 35,
            )
          ],
        ),
      ),
    );
  }
}
