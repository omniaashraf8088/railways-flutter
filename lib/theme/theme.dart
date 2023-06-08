import 'package:flutter/material.dart';

const Color primaryColor100 = Color(0xffbcdaff);
const Color primaryColor300 = Color(0xff88aad6);
const Color primaryColor500 = Color.fromARGB(255, 255, 255, 255);
const Color colorWhite = Colors.white;
const Color backgroundColor = Color(0xffF5F9FF);
const Color lightBlue100 = Color(0xffF0F6FF);
const Color lightBlue300 = Color(0xffD2DFF0);
const Color lightBlue400 = Color(0xffBFC8D2);
const Color darkBlue300 = Color(0xff526983);
const Color darkBlue500 = Color(0xff293948);
const Color darkBlue700 = Color(0xff17212B);
const Color kPrimaryColor = Color(0xFF6F35A5);
const Color kPrimaryLightColor = Color(0xFFF1E6FF);

const Color primaryColor = Color(0xFF04243A);
const Color successColor = Color(0xFF1AB65C);
const Color greyColor = Color(0xFF35383F);
const Color secondaryColor = Color(0xFF001929);
const Color brownColor = Color.fromARGB(255, 63, 63, 63);
const Color yellowColor = Color(0xFFFED201);
const Color tertiaryColor = Color(0xFFCCCCCC);
const Color dangerColor = Color.fromARGB(255, 255, 0, 0);

const double borderRadiusSize = 16.0;

TextStyle greetingTextStyle = const TextStyle(
    fontSize: 24, fontWeight: FontWeight.w700, color: darkBlue500);

TextStyle titleTextStyle = const TextStyle(
    fontSize: 18, fontWeight: FontWeight.w700, color: darkBlue500);

TextStyle subTitleTextStyle = const TextStyle(
    fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white);

TextStyle normalTextStyle = const TextStyle(color: darkBlue500);

TextStyle descTextStyle = const TextStyle(
    fontSize: 14, fontWeight: FontWeight.w400, color: darkBlue300);

TextStyle addressTextStyle = const TextStyle(
    fontSize: 14, fontWeight: FontWeight.w400, color: darkBlue300);

TextStyle facilityTextStyle = const TextStyle(
    fontSize: 13, fontWeight: FontWeight.w500, color: darkBlue300);

TextStyle priceTextStyle = const TextStyle(
    fontSize: 16, fontWeight: FontWeight.w700, color: darkBlue500);

TextStyle buttonTextStyle = const TextStyle(
    fontSize: 16, fontWeight: FontWeight.w600, color: colorWhite);

TextStyle bottomNavTextStyle = const TextStyle(
    fontSize: 12, fontWeight: FontWeight.w500, color: primaryColor500);

TextStyle tabBarTextStyle =
    const TextStyle(fontWeight: FontWeight.w500, color: primaryColor500);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
