import 'package:flutter/material.dart';

class AppValidators {
  static String? displayNameValidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return 'Full name cannot be empty';
    }
    if (displayName.length < 3 || displayName.length > 20) {
      return 'Full name must be between 3 and 20 characters';
    }

    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(
      r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
    ).hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? phoneValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }

    final regex = RegExp(r'^(05\d{8}|(\+966|966)5\d{8})$');

    if (!regex.hasMatch(value)) {
      return "Enter valid Saudi number (05XXXXXXXX or +9665XXXXXXXX)";
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  static String? repeatPasswordValidator({String? value, String? password}) {
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}