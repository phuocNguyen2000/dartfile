import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final String token;
  final String domain;
  const LoggedIn({@required this.token, this.domain});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn { token: $token , domain: $domain}';
}

class LoggedOut extends AuthenticationEvent {}
