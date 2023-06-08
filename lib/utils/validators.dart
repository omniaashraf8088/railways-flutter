import 'package:reservation_railway/constant/constant.dart';

String? passwordValidator(String? value) {
  if (value != null) {
    if (value.isEmpty) {
      return ErrorMessage.requiredField;
    }
    if (value.length < 6) {
      return ErrorMessage.passwordCharacters;
    }
  }
  return null;
}

String? confirmPasswordValidator(String password, String? value) {
  if (value != null) {
    if (value.isEmpty) {
      return ErrorMessage.requiredField;
    }
    if (value.length < 6) {
      return ErrorMessage.passwordCharacters;
    }
    if (password != value) {
      return ErrorMessage.mustMatchPassword;
    }
  }
  return null;
}

String? emailValidator(String? value) {
  if (value != null) {
    if (value.isEmpty) {
      return ErrorMessage.requiredField;
    }
    if (!value.contains('@')) {
      return ErrorMessage.invalidEmail;
    }
  }
  return null;
}

String? requiredValidator(String? value) {
  if (value != null) {
    if (value.isEmpty) {
      return ErrorMessage.requiredField;
    }
  }
  return null;
}

String? ssnValidator(String? value) {
  if (value != null) {
    if (value.isEmpty) {
      return ErrorMessage.requiredField;
    }
    if (value.length != 14) {
      return ErrorMessage.ssn;
    }
  }
  return null;
}

String? phoneNumberValidator(String? value) {
  if (value != null) {
    if (value.isEmpty) {
      return ErrorMessage.requiredField;
    }
    if (!RegularExpression.phoneNumber.hasMatch(value)) {
      return ErrorMessage.phoneNumber;
    }
  }
  return null;
}

String? cardNumberValidator(String? value) {
  if (value != null) {
    if (value.isEmpty) {
      return ErrorMessage.requiredField;
    }
    if (value.length != 14) {
      return ErrorMessage.cardNumber;
    }
  }
  return null;
}

String? cvvValidator(String? value) {
  if (value != null) {
    if (value.isEmpty) {
      return ErrorMessage.requiredField;
    }
    if (value.length != 3) {
      return ErrorMessage.cardNumber;
    }
  }
  return null;
}

String? cardDateValidator(String? value) {
  if (value != null) {
    if (value.isEmpty) {
      return ErrorMessage.requiredField;
    }
    if (value.length != 4) {
      return ErrorMessage.cardDate;
    }
  }
  return null;
}
