import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wcloud/common/constant/env.dart';
import 'package:wcloud/common/http/api_provider.dart';
import 'package:wcloud/common/http/response.dart';
import 'package:wcloud/common/util/internet_check.dart';
import 'package:wcloud/feature/authentication/resource/user_repository.dart';
import 'package:wcloud/feature/home/resource/contact_repository.dart';
import 'index.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc(this.contactRepository, this.addContactBloc)
      : super(ContactInitial());

  String _domain;
  UserRepository userRepository = new UserRepository();

  ContactRepository contactRepository;
  AddContactBloc addContactBloc;
  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is GetContactByID) {
      yield ContactLoading();
      _domain = await userRepository.fetchDomain();
      contactRepository = new ContactRepository(
          env: new Env(_domain),
          apiProvider: new ApiProvider(),
          internetCheck: new InternetCheck());
      try {
        final response = await contactRepository.contact(event.id);
        // ignore: unrelated_type_equality_checks
        if (response.status == Status.Success) {
          addContactBloc.add(AddContactButtonPressed(event.id));
          yield ContactSuccess();
        } else {
          yield ContactInitial();
        }
      } catch (error) {
        yield ContactFailure(error: error.toString());
      }
    }
  }
}
