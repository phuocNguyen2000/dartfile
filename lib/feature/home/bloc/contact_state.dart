import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactSuccess extends ContactState {}

class ContactFailure extends ContactState {
  final String error;

  const ContactFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ContactFailure { error: $error }';
}
