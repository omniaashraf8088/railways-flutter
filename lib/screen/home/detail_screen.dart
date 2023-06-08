import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reservation_railway/model/train.dart';
import 'package:reservation_railway/theme/theme.dart';
import 'package:reservation_railway/utils/notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../payment/payment_way.dart';

class DetailScreen extends StatefulWidget {
  ITrain train;

  DetailScreen({Key? key, required this.train}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Train: ${widget.train.name}'),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Container(
        color: primaryColor,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(
                  right: 24, left: 24, bottom: 24, top: 8),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.train,
                        color: primaryColor500,
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Flexible(
                        child: Text(
                          'From: ${widget.train.from}',
                          overflow: TextOverflow.visible,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: primaryColor500,
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Flexible(
                        child: Text(
                          'To: ${widget.train.to}',
                          overflow: TextOverflow.visible,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        CupertinoIcons.money_dollar_circle_fill,
                        color: primaryColor500,
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Flexible(
                        child: Text(
                          'Price: ${widget.train.price} EGP',
                          overflow: TextOverflow.visible,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.date_range,
                        color: primaryColor500,
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Flexible(
                        child: Text(
                          'Date: ${DateFormat('dd-MM-yyyy').format(widget.train.date)}',
                          overflow: TextOverflow.visible,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        CupertinoIcons.time,
                        color: primaryColor500,
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Flexible(
                        child: Text(
                          'Time: ${widget.train.time}',
                          overflow: TextOverflow.visible,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.event_seat,
                        color: primaryColor500,
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Flexible(
                        child: Text(
                          'Available Seats: ${widget.train.availableSeats.toString()}',
                          overflow: TextOverflow.visible,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.format_list_numbered,
                        color: primaryColor500,
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Flexible(
                        child: Text(
                          'Stand Stations: ${widget.train.standStations.toString()}',
                          overflow: TextOverflow.visible,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.class_,
                        color: primaryColor500,
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Flexible(
                        child: Text(
                          'Category: ${widget.train.category}',
                          overflow: TextOverflow.visible,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: primaryColor,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(
              '${widget.train.price} EGP',
              style: const TextStyle(
                color: successColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 45),
                  primary: successColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadiusSize),
                  ),
                ),
                onPressed: () {
                  if (userData == null) {
                    showSnackBar(
                        context, 'You must to login first', dangerColor);
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PaymentWayWidget(widget.train);
                    }));
                  }
                },
                child: const Text("Book Now!"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
