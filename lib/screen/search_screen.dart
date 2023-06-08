import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reservation_railway/model/category.dart';
import 'package:reservation_railway/model/train.dart';
import 'package:reservation_railway/providers/category.dart';
import 'package:reservation_railway/providers/trains.dart';
import 'package:reservation_railway/screen/home/train_card.dart';

import '../theme/theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _selectedCategory = 'All';
  String _searchText = '';
  bool _isLoading = false;
  bool _isInit = true;
  bool _isDropDownChanged = false;
  final TextEditingController _controller = TextEditingController();

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
      Provider.of<Trains>(context).getTrains();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final trainsData = Provider.of<Trains>(context);
    final List<ITrain> trains = trainsData.items;
    final RouteSettings _settings = ModalRoute.of(context)!.settings;
    if (_settings.arguments != null) {
      final String _cat = _settings.arguments as String;
      if (!_isDropDownChanged) {
        _selectedCategory = _cat;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Reservation Railway'),
        backgroundColor: primaryColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
        // automaticallyImplyLeading: false,
      ),
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 8,
              left: 16,
              right: 16,
              bottom: 8,
            ),
            color: primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [_showDropdown(trains)],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(borderRadiusSize),
              ),
            ),
            child: searchBar(trains),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: trains.length,
              itemBuilder: (context, index) {
                final train = trains[index];
                if (_selectedCategory == 'All') {
                  if (_isNoMatchedResult(train)) {
                    return Container();
                  }
                  return TrainCard(
                    train: train,
                  );
                }
                if (train.category == _selectedCategory) {
                  if (_isNoMatchedResult(train)) {
                    return Container();
                  }
                  return TrainCard(
                    train: train,
                  );
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }

  bool _isNoMatchedResult(ITrain train) {
    return _searchText.isNotEmpty &&
        !train.name.toLowerCase().contains(_searchText.toLowerCase());
  }

  Widget noDataFound() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16, top: 50),
      child: Column(
        children: [
          Image.asset(
            "assets/images/no_match_data_illustration.png",
            width: 200,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            "No Match Data.",
            style: titleTextStyle.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Text(
            "Sorry we couldn't find what you were looking for, \nplease try another train number.",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _showDropdown(List<ITrain> trains) {
    final categoryProvider = Provider.of<Category>(context);
    final List<ICategory> categories = categoryProvider.items;
    return DropdownButton<ICategory>(
      value: categories.firstWhere((cat) => cat.name == _selectedCategory),
      iconEnabledColor: colorWhite,
      iconDisabledColor: darkBlue500,
      dropdownColor: darkBlue500,
      style: normalTextStyle.copyWith(color: colorWhite),
      icon: const Icon(Icons.filter_alt),
      isDense: false,
      isExpanded: false,
      underline: const SizedBox(),
      alignment: Alignment.centerRight,
      items: [
        ...categories.map(
          (category) => DropdownMenuItem<ICategory>(
            value: category,
            child: Text(category.name),
          ),
        ),
      ],
      onChanged: (category) {
        setState(() {
          _isDropDownChanged = true;
          _selectedCategory = category!.name;
        });
      },
    );
  }

  Widget searchBar(List<ITrain> trains) {
    final searchResults = _searchText.isEmpty
        ? trains
        : trains
            .where(
                (t) => t.name.toLowerCase().contains(_searchText.toLowerCase()))
            .toList();
    final isEmpty = searchResults.isEmpty;
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 0,
        bottom: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
            decoration: InputDecoration(
              hintText: "Search by train number...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: colorWhite,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 0.0,
              ),
            ),
          ),
          if (isEmpty) noDataFound()
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
