class FormValidator {
  static bool validateName(String value) {
    if (value.isEmpty) {
      return false;
    }
    String p = "^([a-zA-Z0-9\_\&\#\@]{1,256})" + "\$";
    RegExp regExp = new RegExp(p);
    if (regExp.hasMatch(value)) {
      return true;
    }

    return false;
  }

  static validateDomain(String value) {
    if (value.isEmpty) {
      return false;
    }
    RegExp regExp = new RegExp(
        r'^(?!(https:\/\/|http:\/\/|www\.|mailto:|smtp:|ftp:\/\/|ftps:\/\/))(((([a-zA-Z0-9])|([a-zA-Z0-9][a-zA-Z0-9\-]{0,86}[a-zA-Z0-9]))\.(([a-zA-Z0-9])|([a-zA-Z0-9][a-zA-Z0-9\-]{0,73}[a-zA-Z0-9]))\.(([a-zA-Z0-9]{2,12}\.[a-zA-Z0-9]{2,12})|([a-zA-Z0-9]{2,25})))|((([a-zA-Z0-9])|([a-zA-Z0-9][a-zA-Z0-9\-]{0,162}[a-zA-Z0-9]))\.(([a-zA-Z0-9]{2,12}\.[a-zA-Z0-9]{2,12})|([a-zA-Z0-9]{2,25}))))$');

    if (regExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

  static bool validateEmail(String value) {
    if (value.isEmpty) {
      return false;
    }
    // Regex for email validation
    String p = "^([a-zA-Z0-9\+\.\_\%\-\+]{1,256})" +
        "(\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64})" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")" +
        "\$";
    RegExp regExp = new RegExp(p);
    if (regExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

  static bool validatePassword(String value) {
    if (value.isEmpty) {
      return false;
    }
    //length >=5 && hasNumber=true && hasUppercase=true && hasLowercase=true
    RegExp regExp = new RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{5,}$');
    if (regExp.hasMatch(value)) {
      return true;
    }

    return false;
  }
}
