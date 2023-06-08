import 'package:flutter/material.dart';
import 'package:reservation_railway/constant/constant.dart';
import 'package:reservation_railway/theme/theme.dart';

class FirstWelcomeScreen extends StatelessWidget {
  const FirstWelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/first_welcome.png",
            height: deviceSize.height,
            width: deviceSize.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 0,
            right: 10,
            top: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, Routes.secondWelcome);
                  },
                ),
              ],
            ),
          ),
          Positioned(
            left: 25,
            right: 0,
            bottom: 80,
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 43,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: const [
                    Text(
                      'Book',
                      style: TextStyle(
                        color: successColor,
                        fontSize: 90,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'The best train railways in the century to \n accompany your vacation',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
