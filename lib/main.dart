import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reservation_railway/constant/constant.dart';
import 'package:reservation_railway/firebase_options.dart';
import 'package:reservation_railway/providers/auth.dart';
import 'package:reservation_railway/providers/booking.dart';
import 'package:reservation_railway/providers/card.dart';
import 'package:reservation_railway/providers/category.dart';
import 'package:reservation_railway/providers/trains.dart';
import 'package:reservation_railway/providers/user.dart';
import 'package:reservation_railway/screen/booking/booking_screen.dart';
import 'package:reservation_railway/screen/login/login_screen.dart';
import 'package:reservation_railway/screen/main/main_screen.dart';
import 'package:reservation_railway/screen/chat_bot/chat_bot_screen.dart';
import 'package:reservation_railway/screen/reset_password/reset_password_screen.dart';
import 'package:reservation_railway/screen/signup/signup_screen.dart';
import 'package:reservation_railway/screen/welcome/first_welcome_screen.dart';
import 'package:reservation_railway/screen/welcome/second_welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reservation_railway/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final skipWelcome = prefs.getBool('skipWelcome') ?? false;
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: primaryColor,
  ));
  runApp(ReservationRailway(skipWelcome: skipWelcome));
}

class ReservationRailway extends StatelessWidget {
  final bool skipWelcome;

  const ReservationRailway({Key? key, required this.skipWelcome})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (_) => Auth()),
        ChangeNotifierProvider<Trains>(create: (_) => Trains()),
        ChangeNotifierProvider<Category>(create: (_) => Category()),
        ChangeNotifierProvider<User>(create: (_) => User()),
        ChangeNotifierProvider<CardProvider>(create: (_) => CardProvider()),
        ChangeNotifierProvider<Booking>(create: (_) => Booking()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) {
          return MaterialApp(
            title: 'Reservation Railway',
            debugShowCheckedModeBanner: false,
            home: const FirstWelcomeScreen(),
            routes: {
              Routes.resetPassword: (ctx) => const ResetPasswordScreen(),
              Routes.main: (ctx) => MainScreen(currentScreen: 0),
              Routes.chatBot: (ctx) => const ChatBot(),
              Routes.profile: (ctx) => MainScreen(currentScreen: 3),
              Routes.secondWelcome: (ctx) => const SecondWelcomeScreen(),
              Routes.login: (ctx) => const LoginScreen(),
              Routes.signUp: (ctx) => const SignUpScreen(),
              Routes.search: (ctx) => MainScreen(currentScreen: 1),
              Routes.booking: (ctx) => const BookingScreen()
            },
          );
        },
      ),
    );
  }
}
