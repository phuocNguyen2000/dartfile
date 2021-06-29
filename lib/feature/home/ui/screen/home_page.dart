import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:wcloud/common/constant/env.dart';
import 'package:wcloud/common/http/api_provider.dart';
import 'package:wcloud/common/route/routes.dart';
import 'package:wcloud/common/util/internet_check.dart';
import 'package:wcloud/feature/authentication/bloc/index.dart';
import 'package:wcloud/feature/authentication/resource/user_repository.dart';
import 'package:wcloud/feature/home/bloc/index.dart';
import 'package:wcloud/feature/home/resource/contact_api_provider.dart';
import 'package:wcloud/feature/home/resource/contact_repository.dart';
import 'package:wcloud/generated/l10n.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  UserRepository userRepository = new UserRepository();

  static const platform = const MethodChannel('vcloud.launchcontact');
  bool isContactForm = false;
  int contactID = null;
  bool isVi = false;

  final Completer<InAppWebViewController> _controller =
      Completer<InAppWebViewController>();
  InAppWebViewController _webViewController;

  @override
  void dispose() {
    _HomePageState();
    // close the webview here
    super.dispose();
  }

  ContactRepository contactRepository;
  ContactApiProvider contactApiProvider;
  String _sessionID;
  String _domain;
  @override
  Future<void> initState() {
    super.initState();
    userRepository.fetchToken().then((value) {
      setState(() {
        _sessionID = value;
      });
    });
    userRepository.fetchDomain().then((value) {
      setState(() {
        _domain = value;
      });
    });
    _controller.future.then((controller) {
      _webViewController = controller;
      contactRepository = new ContactRepository(
          env: new Env(_domain),
          apiProvider: new ApiProvider(),
          internetCheck: new InternetCheck());
      contactApiProvider = new ContactApiProvider(
          baseUrl: _domain, apiProvider: new ApiProvider());
      Map<String, String> header = {
        "Cookie": 'session_id=$_sessionID',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "POST,GET,DELETE,PUT,OPTIONS"
      };
      URLRequest urlRequest = URLRequest(url: Uri.parse('https://$_domain'));
      urlRequest.headers = header;
      _webViewController.loadUrl(urlRequest: urlRequest);
    });
  }

  String connectionResult;

  @override
  Widget build(BuildContext context) {
    void displayFloatingButton(String url) async {
      if (url.contains('model=res.partner&view_type=form')) {
        setState(() {
          String string1 = url.split("&").first;
          contactID = int.tryParse(string1.split("id=").last);
        });

        var response = jsonEncode(await contactApiProvider.contact(contactID));
        List<dynamic> result = jsonDecode(response)['result'];
        Map<String, dynamic> jsonResult = Map<String, dynamic>.from(result[0]);

        Iterable<Contact> contact =
            await ContactsService.getContactsForPhone(jsonResult['phone']);

        if (contact.length == 0) {
          setState(() {
            isContactForm = true;
          });
        } else {
          setState(() {
            isContactForm = false;
          });
        }
      } else {
        setState(() {
          isContactForm = false;
        });
      }
    }

    return RepositoryProvider(
        create: (context) => contactRepository,
        child: BlocProvider(
            create: (context) {
              return ContactBloc(contactRepository,
                  new AddContactBloc(contactRepository, contactApiProvider));
            },
            child: BlocListener<ContactBloc, ContactState>(
              listener: (context, state) async {
                if (state is ContactSuccess) {
                  setState(() {
                    isContactForm = false;
                  });
                  final snackBar = SnackBar(
                    content: Text(S.current.add_contact_success),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  setState(() {
                    isContactForm = true;
                  });
                }
              },
              child: BlocBuilder<ContactBloc, ContactState>(
                builder: (context, state) {
                  return Scaffold(
                    body: SafeArea(
                      child: InAppWebView(
                        onWebViewCreated: (InAppWebViewController controller) {
                          _controller.complete(controller);
                        },
                      ),
                      // child: WebView(
                      //   debuggingEnabled: true,
                      //   javascriptMode: JavascriptMode.unrestricted,
                      //   onWebViewCreated:
                      //       (WebViewController webViewController) {
                      //     if (!_controller.isCompleted) {
                      //       _controller.complete(webViewController);
                      //       webViewController.clearCache();
                      //       final cookieManager = CookieManager();
                      //       cookieManager.clearCookies();
                      //     }
                      //   },
                      //   onPageStarted: (url) {},
                      //   navigationDelegate: (NavigationRequest request) {
                      //     if (request.url.contains('logout')) {
                      //       BlocProvider.of<AuthenticationBloc>(context)
                      //           .add(LoggedOut());
                      //       Navigator.pushReplacementNamed(
                      //           context, Routes.landing);

                      //       return NavigationDecision.prevent;
                      //     } else if (request.url.contains(_domain)) {
                      //       displayFloatingButton(request.url);
                      //       return NavigationDecision.navigate;
                      //     } else {
                      //       return NavigationDecision.prevent;
                      //     }
                      //   },
                      // ),
                    ),
                    floatingActionButton: Visibility(
                      visible: isContactForm == true ? true : false,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          context
                              .read<ContactBloc>()
                              .add(GetContactByID(contactID));
                        },
                        label: Text(
                          S.current.add_contact,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                        ),
                        backgroundColor: Color(0xff875a7b),
                      ),
                    ),
                  );
                },
              ),
            )));
  }
}
