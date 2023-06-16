import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reservation_railway/model/http_exception.dart';
import 'package:reservation_railway/model/user.dart';
import 'package:reservation_railway/providers/auth.dart';
import 'package:reservation_railway/providers/user.dart';
import 'package:reservation_railway/screen/profile/not_logged_in.dart';
import 'package:reservation_railway/utils/handle_error.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../theme/theme.dart';
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggedIn = false;
  var userData;

  Future<dynamic> _getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userData')) {
      setState(() {
        _isLoggedIn = true;
        userData =
            json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getAuthData();
  }

  @override
  void didChangeDependencies() {
    Provider.of<User>(context).getUsers();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String userName = '';
    final allUsers = Provider.of<User>(context);
    final List<IUserInfo> users = allUsers.items;
    if (users.isNotEmpty && userData != null && userData['email'] != null) {
      IUserInfo user =
          users.firstWhere((usr) => usr.email == userData['email']);
      userName = user.userName;
    }

    void showLogoutDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content: const Text('Are you sure you want to log out?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  _logout();
                },
                child: const Text('Log out'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: primaryColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _isLoggedIn
              ? Column(
                  children: <Widget>[
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white38.withOpacity(0.50),
                        radius: 120,
                        child: Icon(
                          Icons.person,
                          size: 110,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Center(
                      child: Text(
                        "Welcome ",
                        style: titleTextStyle.copyWith(
                            fontSize: 35, color: darkBlue300),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      userName,
                      style: const TextStyle(color: Colors.white, fontSize: 28),
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
                          showLogoutDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: dangerColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text('Logout'),
                      ),
                    ),
                  ],
                )
              : const NotLoggedIn(),
        ),
      ),
    );
  }

  Future<void> _logout() async {
    try {
      await Provider.of<Auth>(context, listen: false).logout().then((value) {
        setState(() {
          _isLoggedIn = false;
        });
      });
    } on HttpException catch (error) {
      handleAuthError(context, error);
    } catch (error) {
      handleUnknownError(context);
    }
  }
}
