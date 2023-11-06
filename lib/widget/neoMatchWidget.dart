import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Methods/getDateFormate.dart';

neoMatchWidget(
    String matchCategory,
    int oneJoined,
    int twoJoined,
    int threeJoined,
    int fourJoined,
    int fiveJoined,
    int sixJoined,
    int sevenJoined,
    int eightJoined,
    int oneAmount,
    int twoAmount,
    int threeAmount,
    int fourAmount,
    int fiveAmount,
    int sixAmount,
    int sevenAmount,
    int eightAmount,
    String matchId,
    String date) {
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
                  " Neo",
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
                    "1",
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
                    oneJoined.toString(),
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
                    oneAmount.toString(),
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
                    "2",
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
                    twoJoined.toString(),
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
                    twoAmount.toString(),
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
                      color: Colors.purple),
                  child: const Text(
                    "3",
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
                    threeJoined.toString(),
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
                    threeAmount.toString(),
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
                      color: Colors.blue),
                  child: const Text(
                    "4",
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
                    fourJoined.toString(),
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
                    fourAmount.toString(),
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
                      color: Colors.yellow),
                  child: const Text(
                    "5",
                    style: TextStyle(
                        color: Colors.teal,
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
                    fiveJoined.toString(),
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
                    fiveAmount.toString(),
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
                      color: Colors.pink),
                  child: const Text(
                    "6",
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
                    sixJoined.toString(),
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
                    sixAmount.toString(),
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
                      color: Colors.brown),
                  child: const Text(
                    "7",
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
                    sevenJoined.toString(),
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
                    sevenAmount.toString(),
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
                      color: Colors.teal),
                  child: const Text(
                    "9",
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
                    eightJoined.toString(),
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
                    eightAmount.toString(),
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
