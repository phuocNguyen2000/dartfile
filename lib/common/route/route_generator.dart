import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wcloud/common/route/error_route.dart';
import 'package:wcloud/common/widget/loading_widget.dart';
import 'package:wcloud/feature/authentication/resource/user_repository.dart';
import 'package:wcloud/feature/home/ui/screen/home_page.dart';
import 'package:wcloud/feature/login/resources/auth_repository.dart';
import 'package:wcloud/feature/landing/landing_page.dart';
import 'package:wcloud/feature/login/ui/login_page.dart';
import 'package:wcloud/feature/signin_signup/ui/sign_in_page.dart';
import 'package:wcloud/feature/signin_signup/ui/sign_up_page.dart';

import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.landing:
        if (args is AuthRepository) {
          return _createRoute(LoginPage(authRepository: args));
        } else {
          print("CREATE ROUTE  Landing");
          return _createRoute(LandingPage());
        }
        break;
      case Routes.loading:
        return _createRoute(LoadingWidget());

      case Routes.signIn:
        if (args is AuthRepository) {
          print("CREATE ROUTE  Login");
          return _createRoute(LoginPage(authRepository: args));
        }
        break;

      //   return _errorRoute();

      case Routes.signUp:
        // if (args is AuthRepository) {
        //   return MaterialPageRoute<dynamic>(
        //       builder: (_) => SignUpPage(authRepository: args));
        // }
        return MaterialPageRoute<dynamic>(
            builder: (_) => SignUpPage(authRepository: args));

        return errorRoute();

      case Routes.home:
        return _createRoute(HomePage());

      default:
        return errorRoute();
    }
  }
}

Route _createRoute(Widget widget) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            new Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 800));
}
