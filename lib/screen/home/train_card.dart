import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reservation_railway/model/train.dart';
import 'package:reservation_railway/screen/home/detail_screen.dart';
import '../../theme/theme.dart';

class TrainCard extends StatelessWidget {
  final ITrain train;

  const TrainCard({Key? key, required this.train}) : super(key: key);

  void _navigateToBook(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailScreen(
        train: train,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      height: 160,
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
        child: InkWell(
          onTap: () {
            print('ava: ${train.availableSeats}');

            /// Checking if there is available seats or not before navigate to booking page
            if (train.availableSeats > 1) {
              _navigateToBook(context);
            }
          },
          child: Ink(
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
                                train.name,
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
                                    '${DateFormat('dd-MM-yyyy').format(train.date)} - ${train.time}'),
                                const SizedBox(height: 4),
                                _getInfo('${train.from} > ${train.to}'),
                                const SizedBox(height: 8),
                                _getInfo(
                                    'Available Seats: ${train.availableSeats}'),
                                const SizedBox(height: 8),
                                _getInfo(
                                    'Stand Stations: ${train.standStations}'),
                              ],
                            ),
                          ),
                        ],
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
        ),
      ),
    );
  }

  bool get _isExpired {
    return train.date.isBefore(DateTime.now());
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
            train.category,
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
        '${train.price.toString()} EGP',
        style: const TextStyle(
          color: successColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
