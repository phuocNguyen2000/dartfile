import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wcloud/common/constant/env.dart';
import 'package:wcloud/common/http/api_provider.dart';
import 'package:wcloud/common/util/internet_check.dart';
import 'package:wcloud/common/widget/loading_widget.dart';
import 'package:wcloud/feature/authentication/bloc/index.dart';
import 'package:wcloud/feature/home/ui/screen/home_page.dart';
import 'package:wcloud/feature/landing/splash_page.dart';
import 'package:wcloud/feature/login/resources/auth_repository.dart';
import 'package:wcloud/feature/login/ui/login_page.dart';
import 'package:wcloud/feature/no_internet_connection/ui/error_internet_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() {
    // TODO: implement createState
    return _LandingPageState();
  }
}

class _LandingPageState extends State<LandingPage> {
  Map _source = {ConnectivityResult.none: false};
  InternetConnectivity _connectivity = InternetConnectivity.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  String connectionResult;
  @override
  Widget build(BuildContext context) {
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        setState(() {
          connectionResult = "Offline";
        });
        break;
      case ConnectivityResult.mobile:
        {
          setState(() {
            connectionResult = "Online";
          });

          break;
        }
      case ConnectivityResult.wifi:
        {
          setState(() {
            connectionResult = "Online";
          });
        }
    }
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return Container(
              color: Colors.white,
            );
          }
          if (state is AuthenticationAuthenticated) {
            if (connectionResult != 'Offline') {
              return HomePage();
            } else {
              return ErrorInternetPage();
            }
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(
                authRepository: AuthRepository(
                    env: RepositoryProvider.of<Env>(context),
                    apiProvider: RepositoryProvider.of<ApiProvider>(context),
                    internetCheck:
                        RepositoryProvider.of<InternetCheck>(context)));
          }
          return SplashPage();
        });
  }
}

class InternetConnectivity {
  InternetConnectivity._internal();

  static final InternetConnectivity _instance =
      InternetConnectivity._internal();

  static InternetConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else
        isOnline = false;
    } on SocketException catch (_) {
      isOnline = false;
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();
}

// class LandingPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthenticationBloc, AuthenticationState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           if (state is AuthenticationLoading) {
//             return LoadingWidget();
//           }
//           if (state is AuthenticationAuthenticated) {
//             sleep(const Duration(seconds: 1));
//             return HomePage();
//           }
//           if (state is AuthenticationUnauthenticated) {
//             return LoginPage(
//                 authRepository: AuthRepository(
//                     env: RepositoryProvider.of<Env>(context),
//                     apiProvider: RepositoryProvider.of<ApiProvider>(context),
//                     internetCheck:
//                         RepositoryProvider.of<InternetCheck>(context)));
//           }
//           return SplashPage();
//         });
//   }
// }
