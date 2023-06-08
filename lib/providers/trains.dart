import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reservation_railway/constant/constant.dart';
import 'package:reservation_railway/model/train.dart';

class Trains with ChangeNotifier {
  List<ITrain> _items = [];
  List<ITrain> get items {
    return [..._items];
  }

  // ITrain findById(String id) {
  //   return _items.firstWhere((t) => t.id == id);
  // }

  Future<void> getTrains() async {
    Uri url = Uri.https(Constant.dbUrl, '/trains.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      Uri stationUrl = Uri.https(Constant.dbUrl, '/stations.json');
      Uri categoryUrl = Uri.https(Constant.dbUrl, '/categories.json');
      final stationResponse = await http.get(stationUrl);
      final stationsData = json.decode(stationResponse.body);
      final categoryResponse = await http.get(categoryUrl);
      final categoryData = json.decode(categoryResponse.body);
      final List<ITrain> loadedTrains = [];
      if (extractedData.isNotEmpty) {
        extractedData.forEach((trainId, trainData) {
          final String from = trainData['from'];
          final String to = trainData['to'];
          final String categoryId = trainData['category'];

          loadedTrains.add(
            ITrain(
              id: trainId,
              name: trainData['name'],
              category: categoryData[categoryId]['name'],
              price: trainData['price'],
              from: stationsData[from]['name'],
              to: stationsData[to]['name'],
              availableSeats: trainData['availableSeats'],
              date: DateTime.parse(trainData['date']),
              standStations: trainData['standStations'],
              time: trainData['time'],
            ),
          );
        });
      }

      /// Sort trains by date descending
      loadedTrains.sort((a, b) => b.date.compareTo(a.date));
      _items = loadedTrains;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ITrain>> getFutureTickets() async {
    Uri url = Uri.https(Constant.dbUrl, '/trains.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return [];
      }
      Uri stationUrl = Uri.https(Constant.dbUrl, '/stations.json');
      Uri categoryUrl = Uri.https(Constant.dbUrl, '/categories.json');
      final stationResponse = await http.get(stationUrl);
      final stationsData = json.decode(stationResponse.body);
      final categoryResponse = await http.get(categoryUrl);
      final categoryData = json.decode(categoryResponse.body);
      final List<ITrain> loadedTrains = [];
      if (extractedData.isNotEmpty) {
        extractedData.forEach((trainId, trainData) {
          final String from = trainData['from'];
          final String to = trainData['to'];
          final String categoryId = trainData['category'];

          loadedTrains.add(
            ITrain(
              id: trainId,
              name: trainData['name'],
              category: categoryData[categoryId]['name'],
              price: trainData['price'],
              from: stationsData[from]['name'],
              to: stationsData[to]['name'],
              availableSeats: trainData['availableSeats'],
              date: DateTime.parse(trainData['date']),
              standStations: trainData['standStations'],
              time: trainData['time'],
            ),
          );
        });
      }

      /// Sort trains by date descending and filter trains by future dates
      loadedTrains.sort((a, b) => b.date.compareTo(a.date));
      DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
      final List<ITrain> trains = loadedTrains
          .where((train) =>
              train.date.isAfter(tomorrow) ||
              train.date.isAtSameMomentAs(tomorrow))
          .toList();
      return trains;
    } catch (error) {
      rethrow;
    }
  }

  // Future<void> addTrain(ITrain train) async {
  //   final url = Uri.https(Constant.dbUrl, '/trains.json');
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode({
  //         'name': train.name,
  //         'price': train.price,
  //         'category': train.category,
  //         'from': train.from,
  //         'to': train.to,
  //         'date': train.date.toIso8601String(),
  //         'standStations': train.standStations,
  //         'availableSeats': train.availableSeats,
  //         'time': train.time,
  //       }),
  //     );
  //     final newTrain = ITrain(
  //       id: json.decode(response.body)['name'],
  //       name: train.name,
  //       price: train.price,
  //       category: train.category,
  //       from: train.from,
  //       to: train.to,
  //       availableSeats: train.availableSeats,
  //       date: train.date,
  //       time: train.time,
  //       standStations: train.standStations,
  //     );
  //     _items.add(newTrain);
  //     notifyListeners();
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  // Future<void> updateTrain(String id, Train newTrain) async {
  //   final trainIndex = _items.indexWhere((prod) => prod.id == id);
  //   if (trainIndex >= 0) {
  //     final url = Uri.https(Constant.dbUrl, '/trains/$id.json?auth=$authToken');
  //     await http.patch(url,
  //         body: json.encode({
  //           'title': newTrain.title,
  //           'description': newTrain.description,
  //           'imageUrl': newTrain.imageUrl,
  //           'price': newTrain.price
  //         }));
  //     _items[trainIndex] = newTrain;
  //     notifyListeners();
  //   } else {
  //     print('...');
  //   }
  // }

  // Future<void> deleteTrain(String id) async {
  //   final url = Uri.https(Constant.dbUrl, '/trains/$id.json');
  //   final existingTrainIndex = _items.indexWhere((train) => train.id == id);
  //   var existingTrain = _items[existingTrainIndex];
  //   _items.removeAt(existingTrainIndex);
  //   notifyListeners();
  //   final response = await http.delete(url);
  //   if (response.statusCode >= 400) {
  //     _items.insert(existingTrainIndex, existingTrain);
  //     notifyListeners();
  //     throw HttpException('Could not delete train.');
  //   }
  //   // existingTrain = null;
  // }
}
