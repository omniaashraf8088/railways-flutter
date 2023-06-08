import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation_railway/constant/constant.dart';
import 'package:reservation_railway/providers/trains.dart';
import 'package:reservation_railway/screen/admin/train_item.dart';

class TrainsScreen extends StatefulWidget {
  const TrainsScreen({Key? key}) : super(key: key);

  @override
  State<TrainsScreen> createState() => _TrainsScreenState();
}

class _TrainsScreenState extends State<TrainsScreen> {
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
      Provider.of<Trains>(context).getTrains().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final trainsData = Provider.of<Trains>(context);
    final trains = trainsData.items;
    Widget content = trains.isEmpty
        ? const Center(
            child: Text('No Data Found'),
          )
        : ListView.builder(
            itemCount: trains.length,
            itemBuilder: (ctx, i) => TrainItem(trains[i]),
          );
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : content,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.manageTrain);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
