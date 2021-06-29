import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wcloud/common/constant/env.dart';
import 'package:wcloud/common/http/api_provider.dart';
import 'package:wcloud/common/util/internet_check.dart';
import 'package:wcloud/feature/authentication/bloc/index.dart';
import 'package:wcloud/feature/domain/bloc/index.dart';
import 'package:wcloud/feature/login/bloc/index.dart';
import 'package:wcloud/feature/login/resources/auth_repository.dart';
import 'package:wcloud/feature/login/ui/domain_textfield.dart';
import 'package:wcloud/feature/login/ui/form_check_account.dart';
import 'package:wcloud/generated/l10n.dart';

// ignore: must_be_immutable
class FormCheckDomain extends StatefulWidget {
  AuthRepository authRepository;

  FormCheckDomain({this.authRepository});
  _FormCheckDomainState createState() {
    return _FormCheckDomainState();
  }
}

class _FormCheckDomainState extends State<FormCheckDomain> {
  DomainTextField domainTextField = new DomainTextField();
  String error = '';
  void _onCheckButtonPressed() async {
    BlocProvider.of<DomainBloc>(context).add(
        DomainButtonPressed(domain: domainTextField.domainController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DomainBloc, DomainState>(listener: (context, state) {
      if (state is DomainFailure) {
        error = state.error.split(':').last;
      } else if (state is DomainSuccess) {
        error = '';
        widget.authRepository = new AuthRepository(
            env: Env(domainTextField.domainController.text),
            apiProvider: ApiProvider(),
            internetCheck: InternetCheck());
      }
    }, child: BlocBuilder<DomainBloc, DomainState>(builder: (context, state) {
      return Visibility(
        visible: state is DomainSuccess ? false : true,
        child: Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(24)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  domainTextField,
                  AnimatedOpacity(
                    opacity: error != '' ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 200),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  state is DomainLoading
                      ? CircularProgressIndicator()
                      : Container(
                          width: double.infinity,
                          height: 65,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff00ce2d),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24))),
                            child: Text(
                              S.current.check_domain,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              _onCheckButtonPressed();
                            },
                          ),
                        )
                ])),
        replacement: BlocProvider(
          create: (context) {
            return LoginBloc(
              authRepository: widget.authRepository,
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            );
          },
          child: FormCheckAccount(),
        ),
      );
    }));
  }
}
