class IUser {
  final String userName;
  final String password;
  final String confirmPassword;
  final String email;
  final String address;
  final String ssn;
  final String phoneNumber;
  final DateTime createdOn;

  IUser({
    required this.userName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.address,
    required this.ssn,
    required this.phoneNumber,
    required this.createdOn,
  });
}

class IUserInfo {
  final String userName;
  final String email;

  IUserInfo({
    required this.userName,
    required this.email,
  });
}

class LoginCredential {
  final String password;
  final String email;

  LoginCredential({
    required this.email,
    required this.password,
  });
}

class ResetPasswordCredential {
  final String email;

  ResetPasswordCredential({required this.email});
}
