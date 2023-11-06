import 'dart:async';

import 'package:color_wala_admin/Data/DataClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Constrants/DataKey.dart';
import 'LoginScreen.dart';
import 'NavigationBarScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userId = "";

  void setUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      userId = pref.getString(DataKey.userId)!;
      DataClass.userKey = userId;
      // ignore: empty_catches
    } catch (e) {}

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setUser();
    Timer(Duration(seconds: 5), () {
      context.nextAndRemoveUntilPage(
          userId == "" ? LoginScreen() : BottomNavigationBarExampleApp());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/logo1.png"),
          SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.red : Colors.green,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
