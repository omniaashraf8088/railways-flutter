import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_railway/constant/constant.dart';
import 'package:reservation_railway/model/category.dart';
import 'package:reservation_railway/providers/category.dart';
import 'package:reservation_railway/screen/home/category_list.dart';
import 'package:reservation_railway/theme/theme.dart';

class TopSection extends StatefulWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  bool _isLoading = false;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Category>(context).getCategories();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<Category>(context);
    final List<ICategory> categories = categoriesData.items;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16.0, top: 16.0),
          child: const Text(
            "Board your journey\nwith us!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        CategoryList(categories),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Upcoming Trains",
                style: subTitleTextStyle,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.search,
                    arguments: 'All',
                  );
                },
                child: const Text(
                  "Show All",
                  style: TextStyle(color: successColor),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
