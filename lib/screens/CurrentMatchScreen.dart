import 'dart:async';

import 'package:color_wala_admin/screens/EliteTab.dart';
import 'package:color_wala_admin/screens/FizzTab.dart';
import 'package:color_wala_admin/screens/HeroTab.dart';
import 'package:color_wala_admin/screens/NovelTab.dart';
import 'package:color_wala_admin/widget/pageBackgroung.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Constrants/FirebaseKey.dart';
import '../Firebase/FirebaseServices.dart';
import '../Methods/toDigit.dart';
import '../widget/gameNameSlogan.dart';
import '../widget/timerUI.dart';

class CurrentMatch extends StatefulWidget {
  const CurrentMatch({super.key});

  @override
  State<CurrentMatch> createState() => _CurrentMatchState();
}

class _CurrentMatchState extends State<CurrentMatch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          children: const [
            Icon(
              Icons.play_circle,
              color: Colors.red,
            ),
            Text(" Live Match"),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          pageBackground(
              fistBoxColor: Colors.teal,
              flex: 3,
              secondBoxColor: Colors.grey[300]!),
          SizedBox(
            height: double.infinity,
            child: DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  foregroundColor: Colors.teal,
                  backgroundColor: Colors.teal[100],
                  // foregroundColor: Colors.teal,

                  toolbarHeight: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  flexibleSpace: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TabBar(
                        labelColor: Colors.white,
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        unselectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                        unselectedLabelColor: Colors.teal,
                        indicatorColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorPadding: const EdgeInsets.all(6),
                        indicator: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(20), // Creates border
                            color: Colors.teal),
                        tabs: const [
                          Tab(
                              child: Text(
                            'Novel',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          Tab(
                              child: Text('Fizz',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Tab(
                              child: Text('Elite',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          Tab(
                              child: Text('Hero',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      )
                    ],
                  ),
                ),
                body: const TabBarView(
                  children: [
                    NovelTab(),
                    FizzTabb(),
                    EliteTab(),
                    HeroTab(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
