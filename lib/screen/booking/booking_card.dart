import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reservation_railway/model/booking.dart';
import 'package:reservation_railway/screen/booking/booking_details.dart';
import 'package:reservation_railway/screen/booking/cancel_booking.dart';
import 'package:reservation_railway/utils/notifications.dart';

import '../../theme/theme.dart';

class BookingCard extends StatelessWidget {
  final MyBooking booking;

  const BookingCard({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      height: booking.isCanceled ? 150 : 210,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: secondaryColor,
          boxShadow: [
            BoxShadow(
              color: primaryColor500.withOpacity(0.1),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getTrainCategory(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 30,
                              right: 30,
                              top: 18,
                              bottom: 10,
                            ),
                            child: _getTrainIcon(),
                          ),
                          Text(
                            booking.trainNumber,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _getInfo(
                                '${DateFormat('dd-MM-yyyy').format(booking.trainDate)} - ${booking.time}'),
                            const SizedBox(height: 4),
                            _getInfo('${booking.from} > ${booking.to}'),
                            const SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: booking.isCanceled
                                    ? dangerColor
                                    : const Color.fromARGB(255, 102, 102, 102),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: SizedBox(
                                  width: 70,
                                  child: Center(
                                    child: Text(
                                      booking.isCanceled ? 'Cancelled' : 'Paid',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (!booking.isCanceled)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              DateTime dateNow = DateTime.now();
                              DateTime reservationDate = DateTime.parse(
                                  booking.bookingDate.toString());
                              Duration difference =
                                  dateNow.difference(reservationDate);
                              int hoursDifference = difference.inHours;
                              if (hoursDifference > 24) {
                                showSnackBar(
                                    context,
                                    'You can\'t cancel the ticket, it exceeded more than 24 hrs',
                                    dangerColor);
                              } else {
                                showCancelBookingModal(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: const BorderSide(
                                    color: successColor, width: 1),
                              ),
                            ),
                            child: const Text(
                              'Cancel Booking',
                              style: TextStyle(color: successColor),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return BookingDetailsScreen(data: booking);
                              }));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: successColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text('View Ticket'),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _getPrice(),
                if (_isExpired)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Expired',
                      style: TextStyle(
                        color: dangerColor,
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showCancelBookingModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: CancelBooking(
            booking: booking,
          ),
        );
      },
    );
  }

  bool get _isExpired {
    return booking.trainDate.isBefore(DateTime.now());
  }

  Widget _getInfo(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white60,
        fontSize: 16,
      ),
    );
  }

  Widget _getTrainCategory() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: const BoxDecoration(
        color: brownColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: SizedBox(
        width: 65,
        child: Center(
          child: Text(
            booking.category,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTrainIcon() {
    return const CircleAvatar(
      backgroundColor: Colors.white,
      child: Icon(
        Icons.train,
        color: Colors.black,
      ),
    );
  }

  Widget _getPrice() {
    return Container(
      margin: const EdgeInsets.only(top: 15, right: 10),
      child: Text(
        '${booking.price.toString()} EGP',
        style: const TextStyle(
          color: successColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
