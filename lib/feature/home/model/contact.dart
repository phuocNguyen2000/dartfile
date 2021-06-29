import 'dart:typed_data';

import 'package:flutter_contacts/flutter_contacts.dart';

class ContactInfo {
  String id;
  String displayName;
  Name name;
  List<Phone> phones;
  List<Email> emails;
  List<Address> addresses;
  List<Organization> organizations;
  List<Website> websites;
  List<SocialMedia> socialMedias;
  List<Note> notes;
}

class Name {
  String first;
  String last;
}

class Phone {
  String number;
  PhoneLabel label;
}

class Email {
  String address;
  EmailLabel label;
}

class Address {
  String address;
  AddressLabel label;
}

class Organization {
  String company;
  String title;
}

class Website {
  String url;
  WebsiteLabel label;
}

class SocialMedia {
  String userName;
  SocialMediaLabel label;
}

class Note {
  String note;
}