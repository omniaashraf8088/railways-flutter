import 'package:flutter/material.dart';

import 'package:reservation_railway/screen/signup/register.form.dart';
import 'package:reservation_railway/theme/theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fill Your Profile'),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Container(
        color: primaryColor,
        height: screenSize.height,
        width: screenSize.width,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                    right: 16,
                    left: 16,
                  ),
                  child: RegisterForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
