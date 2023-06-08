import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reservation_railway/constant/constant.dart';
import 'package:reservation_railway/model/booking.dart';

class Booking with ChangeNotifier {
  Future<List<MyBooking>> getBooking() async {
    Uri url = Uri.https(Constant.dbUrl, '/booking.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      final List<MyBooking> bookingList = [];
      if (extractedData == null) {
        return bookingList;
      }
      Uri stationUrl = Uri.https(Constant.dbUrl, '/stations.json');
      Uri categoryUrl = Uri.https(Constant.dbUrl, '/categories.json');
      Uri trainsUrl = Uri.https(Constant.dbUrl, '/trains.json');
      final trainsResponse = await http.get(trainsUrl);
      final trainsData = json.decode(trainsResponse.body);
      final stationResponse = await http.get(stationUrl);
      final stationsData = json.decode(stationResponse.body);
      final categoryResponse = await http.get(categoryUrl);
      final categoryData = json.decode(categoryResponse.body);
      if (extractedData.isNotEmpty) {
        extractedData.forEach((bookingId, bookingData) {
          final String trainId = bookingData['trainId'];
          final String from = trainsData[trainId]['from'];
          final String to = trainsData[trainId]['to'];
          final String categoryId = trainsData[trainId]['category'];
          bookingList.add(
            MyBooking(
              id: bookingId,
              userId: bookingData['userId'],
              bookingDate: DateTime.parse(bookingData['date']),
              canCancel: bookingData['canCancel'],
              isCanceled: bookingData['isCanceled'],
              price: trainsData[trainId]['price'],
              time: trainsData[trainId]['time'],
              from: stationsData[from]['name'],
              to: stationsData[to]['name'],
              category: categoryData[categoryId]['name'],
              trainDate: DateTime.parse(trainsData[trainId]['date']),
              trainNumber: trainsData[trainId]['name'],
            ),
          );
        });
      }
      return bookingList;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> book(BookingVm data) async {
    final url = Uri.https(Constant.dbUrl, '/booking.json');
    Uri trainsUrl = Uri.https(Constant.dbUrl, '/trains.json');
    final trainsResponse = await http.get(trainsUrl);
    final trainsData = json.decode(trainsResponse.body);
    try {
      await http.post(
        url,
        body: json.encode({
          'isCanceled': data.isCanceled,
          'canCancel': data.canCancel,
          'date': data.date.toIso8601String(),
          'userId': data.userId,
          'trainId': data.trainId,
        }),
      );
      final int currentAvailableSeats =
          trainsData[data.trainId]['availableSeats'];
      final trainUrl =
          Uri.https(Constant.dbUrl, '/trains/${data.trainId}.json');

      await http.patch(trainUrl,
          body: json.encode({'availableSeats': (currentAvailableSeats - 1)}));
    } catch (error) {
      rethrow;
    }
  }

  Future<void> cancelBooking(MyBooking booking) async {
    final url = Uri.https(Constant.dbUrl, '/booking/${booking.id}.json');
    await http.patch(url,
        body: json.encode({
          'isCanceled': true,
          'canCancel': booking.canCancel,
          'date': booking.bookingDate.toIso8601String(),
          'userId': booking.userId,
        }));
    notifyListeners();
  }
}
