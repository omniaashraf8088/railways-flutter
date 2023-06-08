import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reservation_railway/constant/constant.dart';
import 'package:reservation_railway/model/user.dart';

class User with ChangeNotifier {
  List<IUserInfo> _items = [];
  List<IUserInfo> get items {
    return [..._items];
  }

  Future<void> getUsers() async {
    var url = Uri.https(Constant.dbUrl, '/users.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      final List<IUserInfo> loadedUsers = [];
      if (extractedData.isNotEmpty) {
        extractedData.forEach((userId, userData) {
          loadedUsers.add(
            IUserInfo(
              userName: userData['userName'],
              email: userData['email'],
            ),
          );
        });
      }
      _items = loadedUsers;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
