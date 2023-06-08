import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reservation_railway/constant/constant.dart';
import 'package:reservation_railway/model/train.dart';
import 'package:reservation_railway/providers/trains.dart';
import 'package:reservation_railway/screen/home/top_scection.dart';
import 'package:reservation_railway/theme/theme.dart';
import 'package:reservation_railway/screen/home/train_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Reservation Railway'),
        backgroundColor: primaryColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
      ),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopSection(),
            Consumer<Trains>(
              builder: (context, provider, _) {
                return FutureBuilder<List<ITrain>>(
                  future: provider.getFutureTickets(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error loading items'));
                    } else {
                      final items = snapshot.data!;
                      if (items.isNotEmpty) {
                        return ListView.builder(
                          itemCount: items.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => TrainCard(
                            train: items[index],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.chatBot);
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.chat),
      ),
    );
  }
}
