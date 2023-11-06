import 'package:color_wala_admin/Methods/getDateFormate.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Constrants/FirebaseKey.dart';
import '../Firebase/FirebaseServices.dart';
import '../Methods/changeMatchType.dart';

duoMatchWidget(String matchCategory, int redjoined, int greenJoined,
    int redAmount, int greenAmount, String matchId, String date) {
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(9),
    // height: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: Colors.teal, width: 0.5),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  matchCategory,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
                const Text(
                  " Duo",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.teal),
                ),
              ],
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.teal, width: 0.5),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(1),
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                    child: const Text(
                      "SELECTED",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 9,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(1),
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white24),
                    child: const Text(
                      "JOINEE",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 9,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(1),
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white24),
                    child: const Text(
                      "AMOUNT",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 9,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              ),
            ),
            const HeightBox(5),
            Row(
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(1),
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.red),
                  child: const Text(
                    "Red",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold),
                  ),
                )),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(1),
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white24),
                  child: Text(
                    redjoined.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 9,
                        fontWeight: FontWeight.bold),
                  ),
                )),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(1),
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white24),
                  child: Text(
                    redAmount.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 9,
                        fontWeight: FontWeight.bold),
                  ),
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(1),
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.green),
                  child: const Text(
                    "Green",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold),
                  ),
                )),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(1),
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white24),
                  child: Text(
                    greenJoined.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 9,
                        fontWeight: FontWeight.bold),
                  ),
                )),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(1),
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white24),
                  child: Text(
                    greenAmount.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 9,
                        fontWeight: FontWeight.bold),
                  ),
                )),
              ],
            ),
          ]),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[200]),
              child: Text(
                getDateFormate(date),
                style: const TextStyle(
                    fontSize: 6,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ))
      ],
    ),
  );
}
