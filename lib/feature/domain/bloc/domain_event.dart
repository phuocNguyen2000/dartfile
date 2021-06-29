import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DomainEvent extends Equatable {
  const DomainEvent();
}

class DomainButtonPressed extends DomainEvent {
  final String domain;

  const DomainButtonPressed({
    @required this.domain,
  });

  @override
  List<Object> get props => [domain];

  @override
  String toString() => 'DomainButtonPressed { domain: $domain}';
}
