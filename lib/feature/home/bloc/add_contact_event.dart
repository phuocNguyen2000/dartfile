import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddContactEvent extends Equatable {
  const AddContactEvent();
}

class AddContactButtonPressed extends AddContactEvent {
  final int id;
  const AddContactButtonPressed(this.id);

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'AddContactButtonPressed { id : $id}';
}
