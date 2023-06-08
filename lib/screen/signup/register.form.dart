import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:reservation_railway/constant/constant.dart';
import 'package:reservation_railway/model/http_exception.dart';
import 'package:reservation_railway/model/user.dart';
import 'package:reservation_railway/providers/auth.dart';
import 'package:reservation_railway/theme/theme.dart';
import 'package:reservation_railway/utils/handle_error.dart';
import 'package:reservation_railway/utils/notifications.dart';
import 'package:reservation_railway/utils/validators.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _form = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordObscureText = true;
  bool _confirmPasswordObscureText = true;
  bool _isLoading = false;
  IUser _user = IUser(
    userName: '',
    email: '',
    password: '',
    confirmPassword: '',
    address: '',
    ssn: '',
    phoneNumber: '',
    createdOn: DateTime.now(),
  );

  void _navigateToLogin() {
    Navigator.pushNamed(context, Routes.login);
  }

  Future<void> _addUser() {
    final url = Uri.https(Constant.dbUrl, '/users.json');
    return http.post(
      url,
      body: json.encode({
        'userName': _user.userName,
        'password': _user.password,
        'address': _user.address,
        'ssn': _user.ssn,
        'phoneNumber': _user.phoneNumber,
        'email': _user.email,
        'createdOn': _user.createdOn.toIso8601String()
      }),
    );
  }

  Future<void> _register() async {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false)
            .signUp(_user)
            .then((value) {
          _addUser();
          _form.currentState!.reset();
          showSnackBar(context, 'Register successfully', successColor);
          _navigateToLogin();
        });
      } on HttpException catch (error) {
        handleAuthError(context, error);
      } catch (error) {
        handleUnknownError(context);
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'IUser Name',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                filled: true,
                fillColor: secondaryColor,
              ),
              style: const TextStyle(color: Colors.white),
              textInputAction: TextInputAction.next,
              validator: (val) => requiredValidator(val),
              onSaved: (value) {
                if (value != null) {
                  _user = IUser(
                    userName: value,
                    password: _user.password,
                    confirmPassword: _user.confirmPassword,
                    email: _user.email,
                    address: _user.address,
                    ssn: _user.ssn,
                    phoneNumber: _user.phoneNumber,
                    createdOn: _user.createdOn,
                  );
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                filled: true,
                fillColor: secondaryColor,
              ),
              style: const TextStyle(color: Colors.white),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => emailValidator(val),
              onSaved: (value) {
                if (value != null) {
                  _user = IUser(
                    userName: _user.userName,
                    password: _user.password,
                    confirmPassword: _user.confirmPassword,
                    email: value,
                    address: _user.address,
                    ssn: _user.ssn,
                    phoneNumber: _user.phoneNumber,
                    createdOn: _user.createdOn,
                  );
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              obscureText: _passwordObscureText,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Password',
                labelStyle: const TextStyle(
                  color: Colors.white,
                ),
                filled: true,
                fillColor: secondaryColor,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordObscureText = !_passwordObscureText;
                    });
                  },
                  icon: _passwordObscureText
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  color: Colors.white,
                ),
              ),
              style: const TextStyle(color: Colors.white),
              validator: (val) => passwordValidator(val),
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              onSaved: (value) {
                if (value != null) {
                  _user = IUser(
                    userName: _user.userName,
                    password: value,
                    confirmPassword: _user.confirmPassword,
                    email: _user.email,
                    address: _user.address,
                    ssn: _user.ssn,
                    phoneNumber: _user.phoneNumber,
                    createdOn: _user.createdOn,
                  );
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              obscureText: _confirmPasswordObscureText,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Confirm Password',
                labelStyle: const TextStyle(
                  color: Colors.white,
                ),
                filled: true,
                fillColor: secondaryColor,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _confirmPasswordObscureText =
                          !_confirmPasswordObscureText;
                    });
                  },
                  icon: _confirmPasswordObscureText
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  color: Colors.white,
                ),
              ),
              style: const TextStyle(color: Colors.white),
              validator: (val) =>
                  confirmPasswordValidator(_passwordController.text, val),
              textInputAction: TextInputAction.done,
              onSaved: (value) {
                if (value != null) {
                  _user = IUser(
                    userName: _user.userName,
                    password: _user.password,
                    confirmPassword: value,
                    email: _user.email,
                    address: _user.address,
                    ssn: _user.ssn,
                    phoneNumber: _user.phoneNumber,
                    createdOn: _user.createdOn,
                  );
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'SSN',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                filled: true,
                fillColor: secondaryColor,
              ),
              style: const TextStyle(color: Colors.white),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (val) => ssnValidator(val),
              onSaved: (value) {
                if (value != null) {
                  _user = IUser(
                    userName: _user.userName,
                    password: _user.password,
                    confirmPassword: _user.confirmPassword,
                    email: _user.email,
                    address: _user.address,
                    ssn: value,
                    phoneNumber: _user.phoneNumber,
                    createdOn: _user.createdOn,
                  );
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone Number',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                filled: true,
                fillColor: secondaryColor,
              ),
              style: const TextStyle(color: Colors.white),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (val) => phoneNumberValidator(val),
              onSaved: (value) {
                if (value != null) {
                  _user = IUser(
                    userName: _user.userName,
                    password: _user.password,
                    confirmPassword: _user.confirmPassword,
                    email: _user.email,
                    address: _user.address,
                    ssn: _user.ssn,
                    phoneNumber: value,
                    createdOn: _user.createdOn,
                  );
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                filled: true,
                fillColor: secondaryColor,
              ),
              style: const TextStyle(color: Colors.white),
              textInputAction: TextInputAction.next,
              validator: (val) => requiredValidator(val),
              onSaved: (value) {
                if (value != null) {
                  _user = IUser(
                    userName: _user.userName,
                    password: _user.password,
                    confirmPassword: _user.confirmPassword,
                    email: _user.email,
                    address: value,
                    ssn: _user.ssn,
                    phoneNumber: _user.phoneNumber,
                    createdOn: _user.createdOn,
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  primary: successColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text('Register'),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Already have an account?',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              TextButton(
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 20,
                    color: successColor,
                  ),
                ),
                onPressed: () {
                  _navigateToLogin();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
