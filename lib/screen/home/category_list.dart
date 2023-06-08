import 'package:flutter/material.dart';
import 'package:reservation_railway/model/category.dart';
import 'package:reservation_railway/screen/home/category_card.dart';

class CategoryList extends StatelessWidget {
  final List<ICategory> categories;

  const CategoryList(this.categories, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> categoryList = [];
    for (int i = 0; i < categories.length; i++) {
      categoryList.add(CategoryCard(title: categories[i].name));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: categoryList,
        ),
      ),
    );
  }
}
