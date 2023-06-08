import 'package:flutter/material.dart';
import 'package:reservation_railway/constant/constant.dart';
import 'package:reservation_railway/theme/theme.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  const CategoryCard({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
      child: InkWell(
        highlightColor: primaryColor500.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        splashColor: primaryColor500.withOpacity(0.5),
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            Routes.search,
            arguments: widget.title,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: primaryColor,
            border: Border.all(
              color: successColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 80,
              child: Center(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: successColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
