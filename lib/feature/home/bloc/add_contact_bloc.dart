import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/src/material/scaffold.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:wcloud/common/http/api_provider.dart';
import 'package:wcloud/feature/authentication/resource/user_repository.dart';
import 'package:wcloud/feature/home/resource/contact_api_provider.dart';
import 'package:wcloud/feature/home/resource/contact_repository.dart';
import 'index.dart';

class AddContactBloc extends Bloc<AddContactEvent, AddContactState> {
  AddContactBloc(
    this.contactRepository,
    this.contactApiProvider,
  ) : super(AddContactInitial());
  final ContactRepository contactRepository;
  ContactApiProvider contactApiProvider;
  @override
  Stream<AddContactState> mapEventToState(AddContactEvent event) async* {
    if (event is AddContactButtonPressed) {
      yield AddContactLoading();

      try {
        final response = getContactDataByID(event.id);
        if (response != null) {
          yield AddContactSuccess();
        } else {
          yield AddContactInitial();
        }
      } catch (error) {
        yield AddContactFailure(error: error.toString());
      }
    }
  }

  Future<dynamic> getContactDataByID(int id) async {
    String _domain = await UserRepository().fetchDomain();
    contactApiProvider = new ContactApiProvider(
        baseUrl: _domain, apiProvider: new ApiProvider());
    var response = jsonEncode(await contactApiProvider.contact(id));
    if (response != null) {
      addContact(response);
      return response;
    } else
      return;
  }

  Future<void> addContact(dynamic data) async {
    List<dynamic> result = jsonDecode(data)['result'];
    Map<String, dynamic> jsonResult = Map<String, dynamic>.from(result[0]);

    if (await FlutterContacts.requestPermission()) {
      final newContact = Contact()
        ..displayName = jsonResult['display_name']
        ..phones = [Phone(jsonResult['phone'])]
        ..name.first = jsonResult['name']
        ..emails = [Email(jsonResult['email'])]
        ..organizations = [
          Organization(company: jsonResult['commercial_partner_id'][1])
        ]
        ..addresses = [Address(getAddress(jsonResult))]
        ..websites = [
          Website(jsonResult['website'] != false ? jsonResult['website'] : '')
        ]
        ..photo;

      await newContact.insert();
    }
  }

  String getAddress(Map<String, dynamic> data) {
    String address =
        '${data['street']}, ${data['state_id'][1]} , ${data['city']} ,${data['zip']} , ${data['country_id'][1]}';
    return address;
  }
}
