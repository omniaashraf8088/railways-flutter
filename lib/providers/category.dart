import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reservation_railway/constant/constant.dart';
import 'package:reservation_railway/model/category.dart';

class Category with ChangeNotifier {
  List<ICategory> _items = [];
  List<ICategory> get items {
    return [..._items];
  }

  Future<void> getCategories() async {
    var url = Uri.https(Constant.dbUrl, '/categories.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      final List<ICategory> loadedCategories = [];
      if (extractedData.isNotEmpty) {
        extractedData.forEach((categoryId, categoryData) {
          loadedCategories.add(
            ICategory(
              id: categoryId,
              name: categoryData['name'],
            ),
          );
        });
      }
      loadedCategories.insert(0, ICategory(id: 'all', name: 'All'));
      _items = loadedCategories;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
