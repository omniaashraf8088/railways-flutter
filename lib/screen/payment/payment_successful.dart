import 'package:flutter/material.dart';
import 'package:reservation_railway/constant/constant.dart';
// import 'package:reservation_railway/screen/booking/booking_details.dart';
import 'package:reservation_railway/theme/theme.dart';

class PaymentSuccessful extends StatelessWidget {
  const PaymentSuccessful({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: secondaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/payment_successful.png',
          ),
          const SizedBox(height: 20),
          const Text(
            'Payment Successful!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: successColor,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Successful made payment and ticket booking',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: successColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadiusSize),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.booking);

                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return BookingDetailsScreen(data: booking);
                  // }));
                },
                child: const Text('View Ticket'),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: greyColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadiusSize),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.booking);
                },
                child: const Text('Cancel'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
