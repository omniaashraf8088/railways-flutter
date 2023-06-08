import 'package:flutter/material.dart';
import 'package:reservation_railway/constant/constant.dart';
import 'package:reservation_railway/theme/theme.dart';

class SecondWelcomeScreen extends StatelessWidget {
  const SecondWelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: primaryColor,
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 0,
              top: 0,
              child: Image.asset(
                "assets/images/second_welcome.png",
                width: deviceSize.width,
                height: 396,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 20,
              top: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Let\'s',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 43,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'discover',
                    style: TextStyle(color: Colors.white, fontSize: 43),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'the world',
                    style: TextStyle(color: Colors.white, fontSize: 43),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'with us',
                    style: TextStyle(color: Colors.white, fontSize: 43),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 20),
                    width: deviceSize.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.signUp);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: successColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.all(16.0),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    width: deviceSize.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.main);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: greyColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.all(16.0),
                      ),
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
