import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reservation_railway/constant/constant.dart';
import 'package:reservation_railway/model/card.dart';

class CardProvider with ChangeNotifier {
  List<ICard> _items = [];
  List<ICard> get items {
    return [..._items];
  }

  Future<void> getCards() async {
    Uri url = Uri.https(Constant.dbUrl, '/cards.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      final List<ICard> loadedCards = [];
      if (extractedData.isNotEmpty) {
        extractedData.forEach((cardId, cardData) {
          loadedCards.add(
            ICard(
              id: '',
              cardNumber: cardData['cardNumber'],
              cvv: cardData['cvv'],
              date: cardData['date'],
              userId: cardData['userId'],
              userName: cardData['userName'],
            ),
          );
        });
      }
      _items = loadedCards;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addCard(ICard card) async {
    final url = Uri.https(Constant.dbUrl, '/cards.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'cardNumber': card.cardNumber,
          'cvv': card.cvv,
          'date': card.date,
          'userId': card.userId,
          'userName': card.userName,
        }),
      );
      print('response: ${response.body} ');
      final newCard = ICard(
        id: json.decode(response.body)['name'],
        cardNumber: card.cardNumber,
        cvv: card.cvv,
        date: card.date,
        userId: card.userId,
        userName: card.userName,
      );
      _items.add(newCard);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

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
