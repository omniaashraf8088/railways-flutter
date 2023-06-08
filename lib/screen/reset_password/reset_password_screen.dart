import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_railway/model/user.dart';
import 'package:reservation_railway/providers/auth.dart';
import 'package:reservation_railway/theme/theme.dart';
import 'package:reservation_railway/utils/validators.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  ResetPasswordCredential _credential = ResetPasswordCredential(email: '');

  Future<void> _requestNewPassword() async {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Auth>(context, listen: false)
          .resetPassword(_credential.email)
          .then((value) {
        _form.currentState!.reset();
      });
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        color: primaryColor,
        child: SingleChildScrollView(
          child: SizedBox(
            width: deviceSize.width,
            height: deviceSize.height,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                        ),
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
                            _credential = ResetPasswordCredential(email: value);
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (_isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          onPressed: _requestNewPassword,
                          style: ElevatedButton.styleFrom(
                            primary: successColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text('Send'),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
