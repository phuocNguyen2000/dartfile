import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:wcloud/common/http/response.dart';
import 'package:wcloud/feature/authentication/bloc/index.dart';
import 'package:wcloud/feature/login/bloc/index.dart';
import 'package:wcloud/feature/login/resources/auth_repository.dart';
import 'package:meta/meta.dart';
import '../../../common/util/form_validator.dart' as validator;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authRepository,
    @required this.authenticationBloc,
  })  : assert(authenticationBloc != null),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      // if (validator.FormValidator.validateName(event.username) &&
      //     validator.FormValidator.validatePassword(event.password)) {
      //

      try {
        final db = await authRepository.getDb(event.username, event.password);
        if (db.status == Status.ConnectivityError) {
          yield const LoginFailure(error: "");
        }

        if (db.status == Status.Success) {
          String _db = db.data.toString();
          if (event.username.isNotEmpty && event.password.isNotEmpty) {
            try {
              final response = await authRepository.login(
                  event.username, event.password, _db);
              if (response.status == Status.ConnectivityError) {
                //Internet problem
                yield const LoginFailure(error: "");
              }
              if (response.status == Status.Success) {
                authenticationBloc.add(LoggedIn(
                    token: response.data,
                    domain: authRepository.authApiProvider.baseUrl));
                yield LoginSuccess();
              } else {
                yield LoginFailure(error: response.message);
              }
            } catch (error) {
              yield LoginFailure(error: error.toString());
            }
          } else {
            yield LoginFailure(error: 'Username or password isnt valid');
          }
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
