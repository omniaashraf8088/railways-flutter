import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_railway/model/booking.dart';
import 'package:reservation_railway/model/card.dart';
import 'package:reservation_railway/model/http_exception.dart';
import 'package:reservation_railway/model/train.dart';
import 'package:reservation_railway/providers/booking.dart';
import 'package:reservation_railway/providers/card.dart';
import 'package:reservation_railway/screen/payment/payment_card.dart';
import 'package:reservation_railway/screen/payment/payment_successful.dart';
import 'package:reservation_railway/theme/theme.dart';
import 'package:reservation_railway/utils/handle_error.dart';
import 'package:reservation_railway/utils/notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Payments { paypal, googlePay, applePay }

class PaymentWayWidget extends StatefulWidget {
  final ITrain train;
  const PaymentWayWidget(this.train, {Key? key}) : super(key: key);

  @override
  State<PaymentWayWidget> createState() => _PaymentState();
}

class _PaymentState extends State<PaymentWayWidget> {
  Payments? _payment = Payments.paypal;
  String? _selectedCard = '';
  bool _isLoading = false;
  var userData;
  Future<dynamic> _getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userData')) {
      setState(() {
        userData =
            json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getAuthData();
  }

  @override
  void didChangeDependencies() {
    Provider.of<CardProvider>(context).getCards();
    super.didChangeDependencies();
  }

  Future<void> _book() async {
    DateTime dateNow = DateTime.now();
    setState(() {
      _isLoading = true;
    });
    try {
      BookingVm data = BookingVm(
        userId: userData['userId'],
        trainId: widget.train.id,
        isCanceled: false,
        canCancel: true,
        date: dateNow,
      );
      await Provider.of<Booking>(context, listen: false)
          .book(data)
          .then((value) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const Dialog(
              child: PaymentSuccessful(),
            );
          },
        );
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

  @override
  Widget build(BuildContext context) {
    final cardsData = Provider.of<CardProvider>(context);
    final List<ICard> cards = cardsData.items;
    List<ICard> userCards = [];
    if (userData != null) {
      userCards =
          cards.where((card) => card.userId == userData['userId']).toList();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payment Methods',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const PaymentCardScreen();
                        }));
                      },
                      child: const Text('Add New Card',
                          style: TextStyle(color: successColor)))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              ListTile(
                tileColor: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Row(
                  children: [
                    Image.asset('assets/icons/payPal.png'),
                    const SizedBox(width: 16.0),
                    const Text(
                      'Paypal',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                trailing: Radio<Payments>(
                  activeColor: successColor,
                  value: Payments.paypal,
                  groupValue: _payment,
                  onChanged: (Payments? value) {
                    setState(() {
                      _payment = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ListTile(
                tileColor: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Row(
                  children: [
                    Image.asset('assets/icons/google.png'),
                    const SizedBox(width: 16.0),
                    const Text(
                      'Google Pay',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                trailing: Radio<Payments>(
                  activeColor: successColor,
                  value: Payments.googlePay,
                  groupValue: _payment,
                  onChanged: (Payments? value) {
                    setState(() {
                      _payment = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ListTile(
                tileColor: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Row(
                  children: [
                    Image.asset('assets/icons/applePay.png'),
                    const SizedBox(width: 16.0),
                    const Text(
                      'Apple Pay',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                trailing: Radio<Payments>(
                  activeColor: successColor,
                  value: Payments.applePay,
                  groupValue: _payment,
                  onChanged: (Payments? value) {
                    setState(() {
                      _payment = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Pay with Debit/Credit Card',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              if (userCards.isNotEmpty)
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: userCards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          leading: Image.asset('assets/icons/card-circles.png'),
                          title: Text(
                            '**** **** **** ${userCards[index].cardNumber.substring(userCards[index].cardNumber.length - 4)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            userCards[index].userName,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: Radio<String>(
                            activeColor: successColor,
                            value: userCards[index].cardNumber,
                            groupValue: _selectedCard,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedCard = value;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                )
              else
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'No Cards Added Yet!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
      bottomNavigationBar: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(
                  top: 0, bottom: 35, right: 24, left: 24),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 45),
                  primary: successColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadiusSize),
                  ),
                ),
                onPressed: () {
                  if (userCards.isNotEmpty) {
                    if (_selectedCard == '') {
                      showSnackBar(
                          context, 'Please select a card', dangerColor);
                    } else {
                      _book();
                    }
                  } else {
                    showSnackBar(context, 'Please add a card', dangerColor);
                  }
                },
                child: const Text("Continue"),
              ),
            ),
    );
  }
}
