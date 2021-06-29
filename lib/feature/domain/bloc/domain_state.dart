import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DomainState extends Equatable {
  const DomainState();

  @override
  List<Object> get props => [];
}

class DomainInitial extends DomainState {}

class DomainLoading extends DomainState {}

class DomainSuccess extends DomainState {}

class DomainFailure extends DomainState {
  final String error;

  const DomainFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'DomainFailure { error: $error }';
}
