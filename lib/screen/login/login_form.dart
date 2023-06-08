import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_railway/constant/constant.dart';
import 'package:reservation_railway/model/http_exception.dart';
import 'package:reservation_railway/model/user.dart';
import 'package:reservation_railway/providers/auth.dart';

import 'package:reservation_railway/theme/theme.dart';
import 'package:reservation_railway/utils/handle_error.dart';
import 'package:reservation_railway/utils/validators.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _form = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isLoading = false;
  LoginCredential _credential = LoginCredential(
    email: '',
    password: '',
  );

  Future<void> _login() async {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false)
            .login(_credential.email, _credential.password)
            .then((value) {
          _form.currentState!.reset();
          Navigator.of(context).pushReplacementNamed(Routes.profile);
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
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                  _credential = LoginCredential(
                    password: _credential.password,
                    email: value,
                  );
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: TextFormField(
              obscureText: _obscureText,
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
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: _obscureText
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  color: Colors.white,
                ),
              ),
              style: const TextStyle(color: Colors.white),
              validator: (val) => passwordValidator(val),
              textInputAction: TextInputAction.done,
              onSaved: (value) {
                if (value != null) {
                  _credential = LoginCredential(
                    email: _credential.email,
                    password: value,
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  primary: successColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text('Login'),
              ),
            ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.resetPassword);
            },
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: successColor,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Doesn\'t have an account?',
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 14,
                    color: successColor,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.signUp);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
