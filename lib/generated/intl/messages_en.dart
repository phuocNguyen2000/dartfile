// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        'add_contact_success':
            MessageLookupByLibrary.simpleMessage("Add contact successfully"),
        'retry': MessageLookupByLibrary.simpleMessage("Retry"),
        'no_internet': MessageLookupByLibrary.simpleMessage(
            "No internet connection, please try again"),
        'close_app': MessageLookupByLibrary.simpleMessage("Close app"),
        'add_contact': MessageLookupByLibrary.simpleMessage("Add Contact"),
        'domain_does_not_exist':
            MessageLookupByLibrary.simpleMessage("Domain does not exist"),
        'database_does_not_exist':
            MessageLookupByLibrary.simpleMessage("Database does not exist"),
        'username_or_password_is_incorrect':
            MessageLookupByLibrary.simpleMessage(
                'Username or Password is incorrect'),
        "check_domain": MessageLookupByLibrary.simpleMessage("Check Domain"),
        "does_not_have_account":
            MessageLookupByLibrary.simpleMessage("Does not have account ?"),
        "already_user": MessageLookupByLibrary.simpleMessage("Already a user"),
        "email_hint": MessageLookupByLibrary.simpleMessage("Email"),
        "error": MessageLookupByLibrary.simpleMessage(
            "Error, close the app and try again"),
        "name_hint": MessageLookupByLibrary.simpleMessage("Name"),
        "new_user": MessageLookupByLibrary.simpleMessage("A new user?"),
        "no_results": MessageLookupByLibrary.simpleMessage("No results"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "password_hint": MessageLookupByLibrary.simpleMessage("Password"),
        "please_wait": MessageLookupByLibrary.simpleMessage("Please Wait..."),
        "sign_in": MessageLookupByLibrary.simpleMessage("Sign In"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "signup_success": MessageLookupByLibrary.simpleMessage(
            "Successfully signed up, please Sign In"),
        "user_name_hint": MessageLookupByLibrary.simpleMessage("User Name")
      };
}
