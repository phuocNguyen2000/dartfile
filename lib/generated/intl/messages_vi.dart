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
  String get localeName => 'vi';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        'add_contact_success':
            MessageLookupByLibrary.simpleMessage("Thêm liên hệ thành công"),
        'retry': MessageLookupByLibrary.simpleMessage("Thử lại"),
        'no_internet': MessageLookupByLibrary.simpleMessage(
            "Không có kết nối,vui lòng thử lại"),
        'close_app': MessageLookupByLibrary.simpleMessage("Đóng ứng dụng"),
        'add_contact': MessageLookupByLibrary.simpleMessage("Thêm Liên Hệ"),
        'database_does_not_exist':
            MessageLookupByLibrary.simpleMessage("Database không tồn tại"),
        'domain_does_not_exist':
            MessageLookupByLibrary.simpleMessage("Tên miền không tồn tại"),
        'username_or_password_is_incorrect':
            MessageLookupByLibrary.simpleMessage(
                'Tên đăng nhập hoặc mật khẩu không hợp lệ'),
        "check_domain": MessageLookupByLibrary.simpleMessage("Kiểm Tra"),
        "does_not_have_account":
            MessageLookupByLibrary.simpleMessage("Chưa có tài Khoản ?"),
        "already_user":
            MessageLookupByLibrary.simpleMessage("Người dùng đã tồn tại"),
        "email_hint": MessageLookupByLibrary.simpleMessage("Email"),
        "error": MessageLookupByLibrary.simpleMessage(
            "Đã xảy ra lỗi,vui lòng đóng ứng dụng và thử lại sau"),
        "name_hint": MessageLookupByLibrary.simpleMessage("Tên"),
        "new_user": MessageLookupByLibrary.simpleMessage("Người dùng mới?"),
        "no_results": MessageLookupByLibrary.simpleMessage("Không có kết quả"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "password_hint": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "please_wait":
            MessageLookupByLibrary.simpleMessage("Vui lòng chờ trong giây lát"),
        "sign_in": MessageLookupByLibrary.simpleMessage("Đăng Nhập"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Đăng Ký"),
        "signup_success": MessageLookupByLibrary.simpleMessage(
            "Đăng ký thành công, vui lòng Đăng nhập "),
        "user_name_hint": MessageLookupByLibrary.simpleMessage("Tên Đăng Nhập")
      };
}
