import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reservation_railway/model/booking.dart';
import 'package:reservation_railway/providers/booking.dart';
import 'package:reservation_railway/screen/qr_scanner/qr_scanner_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/theme.dart';
import 'booking_card.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  var userData;
  final Map<int, String> segments = {
    0: "Cancelled",
    1: "Completed",
  };
  int currentSegment = 1;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Booking'),
        backgroundColor: primaryColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QrScannerScreen(),
              ));
            },
          ),
        ],
      ),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSegmentedControl<int>(
                children: Map<int, Widget>.fromEntries(
                  segments.entries.map((entry) => MapEntry(
                        entry.key,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            entry.value,
                            style: TextStyle(
                                color: currentSegment == entry.key
                                    ? Colors.white
                                    : successColor),
                          ),
                        ),
                      )),
                ),
                groupValue: currentSegment,
                selectedColor: successColor,
                unselectedColor: secondaryColor,
                borderColor: Colors.green,
                onValueChanged: (value) {
                  setState(() {
                    currentSegment = value;
                  });
                },
              ),
            ),
            Consumer<Booking>(
              builder: (context, provider, _) {
                return FutureBuilder<List<MyBooking>>(
                  future: provider.getBooking(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error loading items'));
                    } else {
                      if (userData != null && userData['userId'] != '') {
                        final List<MyBooking> allBooking = snapshot.data!;
                        final isCancelled = currentSegment == 0;
                        List<MyBooking> items = allBooking
                            .where((item) =>
                                item.userId == userData['userId'] &&
                                item.isCanceled == isCancelled)
                            .toList();
                        if (items.isNotEmpty) {
                          return ListView.builder(
                            itemCount: items.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => BookingCard(
                              booking: items[index],
                            ),
                          );
                        } else {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 16.0, left: 16, top: 50),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/no_match_data_illustration.png",
                                    width: 200,
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  const Text(
                                    'You don\'t booked any ticket yet!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      } else {
                        return const Center(
                          child: Text(
                            'You must to login first',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        );
                      }
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
