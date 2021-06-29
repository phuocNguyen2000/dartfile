import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:wcloud/feature/home/ui/screen/home_page.dart';
import 'package:wcloud/feature/landing/landing_page.dart';
import 'package:wcloud/generated/l10n.dart';

class ErrorInternetPage extends StatefulWidget {
  @override
  _ErrorInternetPageState createState() {
    // TODO: implement createState
    return _ErrorInternetPageState();
  }
}

class _ErrorInternetPageState extends State<ErrorInternetPage> {
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

  bool isLoading = false;

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
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff0077cd), Color(0xff00ce2d)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Icon(Icons.wifi_off,
                                color: Color(0xff00ce2d), size: 50),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Container(
                              child: Text(
                                S.current.no_internet,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff00ce2d)),
                              ),
                            ),
                          ),
                          isLoading
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if (connectionResult == 'Online') {
                                      Navigator.pushNamed(context, 'HomePage');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xff00ce2d),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.replay_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        S.current.retry,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                        ])),
              ],
            ),
          ),
        ),
      ),
    ));
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
