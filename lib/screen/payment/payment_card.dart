import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_railway/model/card.dart';
import 'package:reservation_railway/model/http_exception.dart';
import 'package:reservation_railway/providers/card.dart';
import 'package:reservation_railway/theme/theme.dart';
import 'package:reservation_railway/utils/handle_error.dart';
import 'package:reservation_railway/utils/notifications.dart';
import 'package:reservation_railway/utils/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentCardScreen extends StatefulWidget {
  const PaymentCardScreen({Key? key}) : super(key: key);

  @override
  State<PaymentCardScreen> createState() => _PaymentCardScreenState();
}

class _PaymentCardScreenState extends State<PaymentCardScreen> {
  var userData;
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  ICard _card = ICard(
    id: '',
    cardNumber: '',
    cvv: '',
    date: '',
    userId: '',
    userName: '',
  );

  Future<dynamic> _getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userData')) {
      setState(() {
        userData =
            json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
      });
    }
  }

  Future<void> _save() async {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<CardProvider>(context, listen: false)
            .addCard(_card)
            .then((value) {
          _form.currentState!.reset();
          showSnackBar(context, 'Card added successfully', successColor);
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
  void initState() {
    super.initState();
    _getAuthData();
  }

  @override
  Widget build(BuildContext context) {
    if (userData != null && userData['userId'] != '') {
      final String userId = userData['userId'];
      _card = ICard(
        id: _card.id,
        userId: userId,
        userName: _card.userName,
        cardNumber: _card.cardNumber,
        date: _card.date,
        cvv: _card.cvv,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Card'),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/icons/card.png',
                      height: 220,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset(
                          'assets/icons/right_circle.png',
                          height: 220,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'Balance',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '75,000 EGP',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset('assets/icons/bottom_circle.png'),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Image.asset('assets/icons/red_circle.png'),
                    ),
                    Positioned(
                      top: 10,
                      right: 35,
                      child: Image.asset('assets/icons/orange_circle.png'),
                    ),
                    Positioned(
                      bottom: 30,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const <Widget>[
                          Text(
                            '11/22',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '• • •  • • •  • • •  8399 3241',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: secondaryColor,
                        ),
                        style: const TextStyle(color: Colors.white),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        validator: (val) => requiredValidator(val),
                        onSaved: (value) {
                          if (value != null) {
                            _card = ICard(
                              id: _card.id,
                              userId: _card.userId,
                              userName: value,
                              cardNumber: _card.cardNumber,
                              date: _card.date,
                              cvv: _card.cvv,
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Number',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: secondaryColor,
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (val) => cardNumberValidator(val),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          if (value != null) {
                            _card = ICard(
                              id: _card.id,
                              userId: _card.userId,
                              userName: _card.userName,
                              cardNumber: value,
                              date: _card.date,
                              cvv: _card.cvv,
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Date',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                filled: true,
                                fillColor: secondaryColor,
                              ),
                              style: const TextStyle(color: Colors.white),
                              validator: (val) => cardDateValidator(val),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              onSaved: (value) {
                                if (value != null) {
                                  _card = ICard(
                                    id: _card.id,
                                    userId: _card.userId,
                                    userName: _card.userName,
                                    cardNumber: _card.cardNumber,
                                    date: value,
                                    cvv: _card.cvv,
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Cvv',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                filled: true,
                                fillColor: secondaryColor,
                              ),
                              style: const TextStyle(color: Colors.white),
                              validator: (val) => cvvValidator(val),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              onSaved: (value) {
                                if (value != null) {
                                  _card = ICard(
                                    id: _card.id,
                                    userId: _card.userId,
                                    userName: _card.userName,
                                    cardNumber: _card.cardNumber,
                                    date: _card.date,
                                    cvv: value,
                                  );
                                }
                              },
                            ),
                          )
                        ],
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
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 45),
                              primary: successColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(borderRadiusSize),
                              ),
                            ),
                            onPressed: _save,
                            child: const Text('Add New Card'),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
