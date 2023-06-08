class Constant {
  static String dbUrl = 'reservation-railway-default-rtdb.firebaseio.com';
  static String apiKey = 'AIzaSyCUHJ52W-JEUPR2x0rfmFmgDGsWrUPUy8I';
  static String firebaseRestApi =
      'https://identitytoolkit.googleapis.com/v1/accounts:';
  static String signUp = '${firebaseRestApi}signUp?key=$apiKey';
  static String signInWithPassword =
      '${firebaseRestApi}signInWithPassword?key=$apiKey';
}

class Routes {
  static String resetPassword = '/reset-password';
  static String adminHomeScreen = '/admin-home-screen';
  static String manageTrain = '/manage-train';
  static String login = '/login';
  static String main = '/main';
  static String chatBot = '/chatBot';
  static String profile = '/profile';
  static String secondWelcome = '/second-welcome';
  static String signUp = '/sign-up';
  static String search = '/search';
  static String booking = '/booking';
}

class ErrorMessage {
  static String requiredField = 'This field is required.';
  static String invalidEmail = 'Invalid email address.';
  static String passwordCharacters = 'Password must be more than 6 characters.';
  static String mustMatchPassword =
      'Password and Confirm Password must be match.';
  static String ssn = 'SSN must be 14 digits.';
  static String cardNumber = 'Card number must be 14 digits.';
  static String cvv = 'CVV must be 3 digits.';
  static String cardDate = 'Date must be 4 digits (MMYY).';
  static String phoneNumber =
      'Must be 11 digits and start with (010, 011, 012 or 015).';
}

class RegularExpression {
  static RegExp phoneNumber = RegExp('^(010|011|012|015)[0-9]{8}\$');
}

const defaultPadding = 8.0;
