import 'package:flutter/material.dart';
import 'package:reservation_railway/constant/constant.dart';
import 'package:reservation_railway/theme/theme.dart';

class NotLoggedIn extends StatelessWidget {
  const NotLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Center(
          child: Icon(
            Icons.person,
            size: 260,
            color: Colors.white, // kPrimaryColor,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Center(
          child: Text(
            "You don't logged in yet.",
            style: titleTextStyle.copyWith(fontSize: 24, color: darkBlue300),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "Please sign in to can enjoy with all features and to be able to book your train tickets",
          style: descTextStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 60,
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.login);
            },
            style: ElevatedButton.styleFrom(
              primary: successColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text('Login'),
          ),
        ),
      ],
    );
  }
}
