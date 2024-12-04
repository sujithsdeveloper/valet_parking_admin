class Validations {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
        .hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateName(String? value){
    if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
  }

  static String? slotsValidation(String? value){
    if (value == null || value.isEmpty) {
          return 'Please enter slots';
        }
        return null;
  }
  static String? locationValidation(String? value){
    if (value == null || value.isEmpty) {
          return 'Please enter the coordinates';
        }
        return null;
  }
  static String? priceValidation(String? value){
    if (value == null || value.isEmpty) {
          return 'Please enter price per hour';
        }
        return null;
  }


  static String? validatePhoneNumber(String? value) {
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!phoneRegExp.hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  
}



