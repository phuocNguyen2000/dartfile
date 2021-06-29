import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
}

class GetContactByID extends ContactEvent {
  final int id;
  const GetContactByID(this.id);

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'GetContactByID { id: $id }';
}
