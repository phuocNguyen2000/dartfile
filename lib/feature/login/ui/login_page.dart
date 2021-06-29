import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wcloud/common/http/api_provider.dart';
import 'package:wcloud/common/util/internet_check.dart';
import 'package:wcloud/feature/authentication/bloc/index.dart';
import 'package:wcloud/feature/authentication/resource/user_repository.dart';
import 'package:wcloud/feature/domain/bloc/index.dart';
import 'package:wcloud/feature/domain/resources/index.dart';
import 'package:wcloud/feature/login/bloc/index.dart';
import 'package:wcloud/feature/login/resources/auth_repository.dart';
import 'package:wcloud/feature/login/ui/form_check_account.dart';
import 'package:wcloud/feature/login/ui/form_check_domain.dart';
import 'package:wcloud/generated/l10n.dart';

class LoginPage extends StatefulWidget {
  AuthRepository authRepository;

  LoginPage({
    Key key,
    @required this.authRepository,
  }) : super(key: key);

  @override
  _LoginPage createState() {
    // TODO: implement createState
    return _LoginPage(authRepository);
  }
}

class _LoginPage extends State<LoginPage> {
  bool isDomainSuccess = false;
  AuthRepository authRepository;
  DomainRepository domainRepository;
  UserRepository userRepository = new UserRepository();
  _LoginPage(AuthRepository authRepository) {
    this.authRepository = authRepository;
  }

  @override
  Widget build(BuildContext context) {
    DomainRepository domainRepository = new DomainRepository(
        apiProvider: new ApiProvider(), internetCheck: new InternetCheck());

    return Scaffold(
        body: MultiRepositoryProvider(
            providers: [
          RepositoryProvider<AuthRepository>(
              create: (context) => authRepository),
          RepositoryProvider(create: (context) => domainRepository)
        ],
            child: Container(
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
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                          child: RichText(
                            text: TextSpan(
                              text: 'V',
                              style: TextStyle(
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2.0,
                                      color: Color(0xff00ce2d),
                                      offset: Offset(1.0, 1.0),
                                    ),
                                  ],
                                  color: Color(0xff00ce2d),
                                  fontSize: 50,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'cloud',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        BlocProvider(
                            create: (context) {
                              return DomainBloc(
                                  domainRepository: domainRepository);
                            },
                            child: FormCheckDomain(
                                authRepository: authRepository)),
                        Container(
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Row(
                              children: <Widget>[
                                Text(S.current.does_not_have_account,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                    )),
                                FlatButton(
                                  textColor: Color(0xff0077cd),
                                  child: Text(
                                    S.current.sign_up,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  onPressed: () {
                                    //signup screen
                                  },
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.end,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
