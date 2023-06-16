import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reservation_railway/model/booking.dart';
import 'package:reservation_railway/theme/theme.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingDetailsScreen extends StatefulWidget {
  MyBooking data;

  BookingDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Train: ${widget.data.trainNumber}'),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Container(
        color: primaryColor,
        child: CustomScrollView(
          slivers: [
            Image.asset("assets/images/train_book.jpg"),
            SliverPadding(
              padding: const EdgeInsets.only(
                  right: 24, left: 24, bottom: 24, top: 8),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
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
                            'From: ${widget.data.from}',
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
                            'To: ${widget.data.to}',
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
                            'Price: ${widget.data.price} EGP',
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
                            'Date: ${DateFormat('dd-MM-yyyy').format(widget.data.trainDate)}',
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
                            'Time: ${widget.data.time}',
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
                            'Category: ${widget.data.category}',
                            overflow: TextOverflow.visible,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.white,
                          child: QrImageView(
                            data: widget.data.id,
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
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
