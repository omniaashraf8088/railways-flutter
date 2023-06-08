import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_railway/model/booking.dart';
import 'package:reservation_railway/model/http_exception.dart';
import 'package:reservation_railway/providers/booking.dart';
import 'package:reservation_railway/theme/theme.dart';
import 'package:reservation_railway/utils/handle_error.dart';

import '../../utils/notifications.dart';

class CancelBooking extends StatelessWidget {
  final MyBooking booking;

  const CancelBooking({
    Key? key,
    required this.booking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: secondaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Cancel Booking',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Are you sure you want to cancel your ticket bookings?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            'Only 80% of the money you can refund from your payment according to our policy',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: greyColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadiusSize),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: successColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadiusSize),
                  ),
                ),
                onPressed: () {
                  _cancelBooking(context);
                },
                child: const Text('Yes, Continue'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _cancelBooking(BuildContext context) async {
    try {
      await Provider.of<Booking>(context, listen: false)
          .cancelBooking(booking)
          .then((value) {
        Navigator.pop(context);
        showSnackBar(context, 'Cancelled successfully', successColor);
      });
    } on HttpException catch (error) {
      handleAuthError(context, error);
    } catch (error) {
      handleUnknownError(context);
    }
  }
}
