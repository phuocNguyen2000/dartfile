import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddContactState extends Equatable {
  const AddContactState();

  List<Object> get props => [];
}

class AddContactInitial extends AddContactState {}

class AddContactLoading extends AddContactState {}

class AddContactSuccess extends AddContactState {}

class AddContactFailure extends AddContactState {
  final String error;

  const AddContactFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AddContactFailure { error: $error }';
}
