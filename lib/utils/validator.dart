class Validator {
  static bool _isEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  static String? email(String? value) {
    if (_isEmpty(value) || !value!.contains("@")) {
      return "Please enter a valid email address";
    }
    return null;
  }

  static String? password(String? value) {
    if (_isEmpty(value) || value!.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  static String? name(String? value) {
    return _isEmpty(value) ? "Please enter your name" : null;
  }

  static String? confirmPassword(String? value, String password) {
    if (_isEmpty(value) || value != password) {
      return "Passwords do not match";
    }
    return null;
  }
}
