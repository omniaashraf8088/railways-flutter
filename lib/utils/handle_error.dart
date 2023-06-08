import 'package:flutter/material.dart';
import 'package:reservation_railway/model/http_exception.dart';
import 'package:reservation_railway/utils/notifications.dart';

handleAuthError(BuildContext context, HttpException error) {
  String errorMessage = 'Authentication failed';
  if (error.toString().contains('EMAIL_EXISTS')) {
    errorMessage = 'This email address is already in use.';
  } else if (error.toString().contains('INVALID_EMAIL')) {
    errorMessage = 'This is not a valid email address';
  } else if (error.toString().contains('WEAK_PASSWORD')) {
    errorMessage = 'This password is too weak.';
  } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
    errorMessage = 'Could not find a user with that email.';
  } else if (error.toString().contains('INVALID_PASSWORD')) {
    errorMessage = 'Invalid password.';
  }
  showErrorDialog(context, errorMessage);
}

handleUnknownError(BuildContext context) {
  const String errorMessage = 'Something went wrong, Please try again later.';
  showErrorDialog(context, errorMessage);
}
