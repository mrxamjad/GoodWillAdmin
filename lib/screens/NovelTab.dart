import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_wala_admin/Methods/changeMatchType.dart';
import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import '../Constrants/FirebaseKey.dart';
import '../Firebase/FirebaseServices.dart';
import '../Methods/toDigit.dart';
import '../widget/gameNameSlogan.dart';
import '../widget/pageBackgroung.dart';
import '../widget/timerUI.dart';

class NovelTab extends StatefulWidget {
  const NovelTab({super.key});

  @override
  State<NovelTab> createState() => _NovelTabState();
}

class _NovelTabState extends State<NovelTab> {
  StreamController secondController = StreamController();
  StreamController minuteController = StreamController();
  StreamController allowButtonController = StreamController();

  late Stream allowButtonStream;

  Timer? timer;
  String startDate = "";
  int remainTime = 0;
  bool allowButton = true;
  String matchId = "";

  int? neoSelected = 0;
  int? duoSelected = 0;
  int? trioSelected = 0;
  var duoItem;
  var trioItem;
  var neoItem;
  String matchCategory = "NOVEL";

  @override
  void initState() {
    super.initState();
    neoSelected = 0;
    duoSelected = 0;
    trioSelected = 0;
    Timer(const Duration(seconds: 1), () {
      setState(() {});
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {});
    });
    Timer(const Duration(seconds: 5), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pageBackground(
              fistBoxColor: Colors.teal,
              flex: 3,
              secondBoxColor: Colors.grey[200]!),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: StreamBuilder(
                                  stream: FirebaseService.currentMatchRef
                                      .doc("novel")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var data = snapshot.data;
                                      matchId =
                                          data![FirebaseKey.duoId].toString();
                                      var part = data[FirebaseKey.duoId]
                                          .toString()
                                          .substring(2);
                                      return Text("ID: N$part",
                                          style: const TextStyle(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 9));
                                    } else {
                                      return const Text("ID: --:--",
                                          style: TextStyle(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 9));
                                    }
                                  })),
                          const Icon(
                            Icons.flag,
                            color: Colors.teal,
                            size: 32,
                          ),
                        ],
                      ),
                      gameNameSlogan(matchCategory, "2:30 Min Match"),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                timerUI("C"),
                                timerUI("O"),
                                timerUI("U"),
                                timerUI("N"),
                                timerUI("T"),
                                const WidthBox(2),
                                timerUI("D"),
                                timerUI("O"),
                                timerUI("W"),
                                timerUI("N"),
                              ],
                            ),
                          ),
                          StreamBuilder(
                              stream: FirebaseService.currentMatchRef
                                  .doc("novel")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var data = snapshot.data;
                                  String time =
                                      data![FirebaseKey.matchStartTime];

                                  DateTime startTime = DateTime.parse(time);
                                  startDate = time;

                                  var addedTime = startTime
                                      .add(const Duration(seconds: 150));
                                  int leftTime = addedTime
                                      .difference(DateTime.now())
                                      .inSeconds;

                                  int minute = 0;
                                  int second = 0;

                                  Timer.periodic(const Duration(seconds: 1),
                                      (timer) {
                                    if (leftTime <= 0) {
                                      timer.cancel();
                                    } else {
                                      leftTime--;
                                      remainTime = leftTime;
                                    }

                                    if (leftTime > 30) {
                                      allowButton = true;
                                    } else {
                                      allowButton = false;
                                    }

                                    minute = leftTime ~/ 60;
                                    second = leftTime % 60;

                                    secondController.sink.add(second);
                                    minuteController.sink.add(minute);
                                    allowButtonController.sink.add(allowButton);
                                  });
                                  return Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.teal,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                            child: StreamBuilder(
                                                stream: minuteController.stream,
                                                builder: (context, spapshot) {
                                                  return Text(
                                                    toDigit(minute),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22),
                                                  );
                                                })),
                                      ),
                                      const Text(
                                        ":",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.teal,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                            child: StreamBuilder(
                                                stream: secondController.stream,
                                                builder: (context, snapshot) {
                                                  return Text(
                                                    toDigit(second),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22),
                                                  );
                                                })),
                                      ),
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                        ],
                      )
                    ],
                  ),
                ),
                if (matchId.isNotEmptyAndNotNull)
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseKey.matchHistory)
                          .doc(FirebaseKey.novel)
                          .collection(FirebaseKey.novel)
                          .doc(changeMatchIdType(matchId, "D"))
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!;

                          if (duoSelected == 0) {
                            if (data[FirebaseKey.highAmount] == true) {
                              duoSelected = 1;
                            } else if (data[FirebaseKey.winnerSelected] ==
                                true) {
                              duoSelected = 3;
                              duoItem = data[FirebaseKey.matchWinner];
                            } else {
                              duoSelected = 2;
                            }
                          }
                          return Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(9),
                            // height: 111,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.teal, width: 0.5),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                              fontSize: 11,
                                              color: Colors.teal),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            color: Colors.teal, width: 0.5),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                                              borderRadius:
                                                  BorderRadius.circular(30),
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
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Colors.white24),
                                          child: Text(
                                            data[FirebaseKey.redJoinee]
                                                .toString(),
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
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Colors.white24),
                                          child: Text(
                                            data[FirebaseKey.redAmount]
                                                .toString(),
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
                                              borderRadius:
                                                  BorderRadius.circular(30),
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
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Colors.white24),
                                          child: Text(
                                            data[FirebaseKey.greenJoinee]
                                                .toString(),
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
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Colors.white24),
                                          child: Text(
                                            data[FirebaseKey.greenAmount]
                                                .toString(),
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
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(
                                        color: Colors.teal, width: 0.5),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: const [
                                          Text(
                                            "Winner Selection",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                                color: Colors.teal),
                                          ),
                                          // Row(
                                          //   children: const [
                                          //     Icon(
                                          //       Icons.check_circle,
                                          //       color: Colors.green,
                                          //       size: 9,
                                          //     ),
                                          //     Text(
                                          //       " updated",
                                          //       style: TextStyle(
                                          //           fontSize: 9,
                                          //           color: Colors.green),
                                          //     )
                                          //   ],
                                          // )
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
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: 1,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  groupValue: duoSelected,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      duoSelected = value;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                  "Amount",
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: 2,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  groupValue: duoSelected,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      duoSelected = value;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                  "Random",
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: 3,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  groupValue: duoSelected,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      duoSelected = value;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                  "Color",
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          )),
                                        ],
                                      ),
                                      if (duoSelected == 3)
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 0.2)),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      activeColor: Colors.red,
                                                      value: "red",
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      groupValue: duoItem,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          duoItem = value;
                                                        });
                                                      },
                                                    ),
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 9,
                                                                vertical: 3),
                                                        decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        11)),
                                                        child: const Text(
                                                          "Red",
                                                          style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.white),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      activeColor: Colors.green,
                                                      value: "green",
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      groupValue: duoItem,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          duoItem = value;
                                                        });
                                                      },
                                                    ),
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 9,
                                                                vertical: 3),
                                                        decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        11)),
                                                        child: const Text(
                                                          "Green",
                                                          style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.white),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, top: 5),
                                        child: SizedBox(
                                          width: 50,
                                          height: 15,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              11))),
                                              onPressed: () async {
                                                if (duoSelected == 1) {
                                                  await FirebaseService
                                                      .updateMatchWinner(
                                                          FirebaseKey.novel,
                                                          changeMatchIdType(
                                                              matchId, "D"),
                                                          "",
                                                          false,
                                                          true);
                                                }
                                                if (duoSelected == 2) {
                                                  await FirebaseService
                                                      .updateMatchWinner(
                                                          FirebaseKey.novel,
                                                          changeMatchIdType(
                                                              matchId, "D"),
                                                          "",
                                                          false,
                                                          false);
                                                }
                                                if (duoSelected == 3) {
                                                  await FirebaseService
                                                      .updateMatchWinner(
                                                          FirebaseKey.novel,
                                                          changeMatchIdType(
                                                              matchId, "D"),
                                                          duoItem,
                                                          true,
                                                          false);
                                                }
                                              },
                                              child: const Text(
                                                "SET",
                                                style: TextStyle(fontSize: 9),
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.teal));
                      }),
                if (matchId.isNotEmptyAndNotNull)
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseKey.matchHistory)
                          .doc(FirebaseKey.novel)
                          .collection(FirebaseKey.novel)
                          .doc(changeMatchIdType(matchId, "T"))
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!;
                          if (trioSelected == 0) {
                            if (data[FirebaseKey.highAmount] == true) {
                              trioSelected = 1;
                            } else if (data[FirebaseKey.winnerSelected] ==
                                true) {
                              trioSelected = 3;
                              trioItem = data[FirebaseKey.matchWinner];
                            } else {
                              trioSelected = 2;
                            }
                          }
                          return Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(9),
                            // height: 111,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.teal, width: 0.5),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          matchCategory,
                                          style: const TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal),
                                        ),
                                        const Text(
                                          " Trio",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                              color: Colors.teal),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              color: Colors.teal, width: 0.5),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(1),
                                              margin: const EdgeInsets.all(1),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.white),
                                              child: const Text(
                                                "SELECTED",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 9,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                            Expanded(
                                                child: Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(1),
                                              margin: const EdgeInsets.all(1),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.white24),
                                              child: const Text(
                                                "JOINEE",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 9,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                            Expanded(
                                                child: Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(1),
                                              margin: const EdgeInsets.all(1),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.white24),
                                              child: const Text(
                                                "AMOUNT",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 9,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.blue),
                                            child: const Text(
                                              "Blue",
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.blueJoinee]
                                                  .toString(),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.blueAmount]
                                                  .toString(),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.pink),
                                            child: const Text(
                                              "Pink",
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.pinkJoinee]
                                                  .toString(),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.pinkAmount]
                                                  .toString(),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.purple),
                                            child: const Text(
                                              "Purple",
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.purpleJoinee]
                                                  .toString(),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.purpleAmount]
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(
                                        color: Colors.teal, width: 0.5),
                                  ),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Winner Selection",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                            color: Colors.teal),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: 1,
                                                  splashRadius: 0.2,
                                                  groupValue: trioSelected,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      trioSelected = value;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                  "Amount",
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: 2,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  groupValue: trioSelected,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      trioSelected = value;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                  "Random",
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: 3,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  groupValue: trioSelected,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      trioSelected = value;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                  "Color",
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          )),
                                        ],
                                      ),
                                      if (trioSelected == 3)
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 0.2)),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      activeColor: Colors.blue,
                                                      value: "blue",
                                                      groupValue: trioItem,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          trioItem = value;
                                                        });
                                                      },
                                                    ),
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 9,
                                                                vertical: 3),
                                                        decoration: BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        11)),
                                                        child: const Text(
                                                          "Blue",
                                                          style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.white),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      activeColor: Colors.pink,
                                                      value: "pink",
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      groupValue: trioItem,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          trioItem = value;
                                                        });
                                                      },
                                                    ),
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 9,
                                                                vertical: 3),
                                                        decoration: BoxDecoration(
                                                            color: Colors.pink,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        11)),
                                                        child: const Text(
                                                          "Pink",
                                                          style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.white),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      activeColor:
                                                          Colors.purple,
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      value: "purple",
                                                      groupValue: trioItem,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          trioItem = value;
                                                        });
                                                      },
                                                    ),
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 9,
                                                                vertical: 3),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.purple,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        11)),
                                                        child: const Text(
                                                          "Purple",
                                                          style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.white),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 3),
                                        child: SizedBox(
                                          width: 50,
                                          height: 15,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              11))),
                                              onPressed: () async {
                                                if (trioSelected == 1) {
                                                  await FirebaseService
                                                      .updateMatchWinner(
                                                          FirebaseKey.novel,
                                                          changeMatchIdType(
                                                              matchId, "T"),
                                                          "",
                                                          false,
                                                          true);
                                                }
                                                if (trioSelected == 2) {
                                                  await FirebaseService
                                                      .updateMatchWinner(
                                                          FirebaseKey.novel,
                                                          changeMatchIdType(
                                                              matchId, "T"),
                                                          "",
                                                          false,
                                                          false);
                                                }
                                                if (trioSelected == 3) {
                                                  await FirebaseService
                                                      .updateMatchWinner(
                                                          FirebaseKey.novel,
                                                          changeMatchIdType(
                                                              matchId, "T"),
                                                          trioItem,
                                                          true,
                                                          false);
                                                }
                                              },
                                              child: const Text(
                                                "SET",
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.teal),
                        );
                      }),
                if (matchId.isNotEmptyAndNotNull)
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseKey.matchHistory)
                          .doc(FirebaseKey.novel)
                          .collection(FirebaseKey.novel)
                          .doc(changeMatchIdType(matchId, "N"))
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!;
                          if (neoSelected == 0) {
                            if (data[FirebaseKey.highAmount] == true) {
                              neoSelected = 1;
                            } else if (data[FirebaseKey.winnerSelected] ==
                                true) {
                              neoSelected = 3;
                              neoItem = data[FirebaseKey.matchWinner];
                            } else {
                              neoSelected = 2;
                            }
                          }

                          return Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(9),
                            // height: 111,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.teal, width: 0.5),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              color: Colors.teal, width: 0.5),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(1),
                                              margin: const EdgeInsets.all(1),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.white),
                                              child: const Text(
                                                "SELECTED",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 9,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                            Expanded(
                                                child: Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(1),
                                              margin: const EdgeInsets.all(1),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.white24),
                                              child: const Text(
                                                "JOINEE",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 9,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                            Expanded(
                                                child: Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(1),
                                              margin: const EdgeInsets.all(1),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.white24),
                                              child: const Text(
                                                "AMOUNT",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 9,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.oneJoinee]
                                                  .toString(),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.oneAmount]
                                                  .toString(),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.twoJoinee]
                                                  .toString(),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.twoAmount]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.black,
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.threeJoinee]
                                                  .toString(),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.threeAmount]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.black,
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.blue),
                                            child: const Text(
                                              "4",
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.fourJoinee]
                                                  .toString(),
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.fourAmount]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.black,
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.yellow),
                                            child: const Text(
                                              "5",
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.fiveJoinee]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.fiveAmount]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.black,
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.pink),
                                            child: const Text(
                                              "6",
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.sixJoinee]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.sixAmount]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.black,
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.brown),
                                            child: const Text(
                                              "7",
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.sevenJoinee]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.sevenAmount]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.black,
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
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.teal),
                                            child: const Text(
                                              "9",
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.eightJoinee]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white24),
                                            child: Text(
                                              data[FirebaseKey.eightAmount]
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(
                                        color: Colors.teal, width: 0.5),
                                  ),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Winner Selection",
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: 1,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  groupValue: neoSelected,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      neoSelected = value;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                  "Amount",
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: 2,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  groupValue: neoSelected,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      neoSelected = value;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                  "Random",
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: 3,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  groupValue: neoSelected,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      neoSelected = value;
                                                    });
                                                  },
                                                ),
                                                const Text(
                                                  "Color",
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          )),
                                        ],
                                      ),
                                      if (neoSelected == 3)
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 0.2),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Radio(
                                                          activeColor:
                                                              Colors.red,
                                                          value: "1",
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          groupValue: neoItem,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              neoItem = value;
                                                            });
                                                          },
                                                        ),
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        9,
                                                                    vertical:
                                                                        3),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            11)),
                                                            child: const Text(
                                                              "1",
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .white),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Radio(
                                                          activeColor:
                                                              Colors.green,
                                                          value: "2",
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          groupValue: neoItem,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              neoItem = value;
                                                            });
                                                          },
                                                        ),
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        9,
                                                                    vertical:
                                                                        3),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            11)),
                                                            child: const Text(
                                                              "2",
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .white),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Radio(
                                                          activeColor:
                                                              Colors.purple,
                                                          value: "3",
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          groupValue: neoItem,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              neoItem = value;
                                                            });
                                                          },
                                                        ),
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        9,
                                                                    vertical:
                                                                        3),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .purple,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            11)),
                                                            child: const Text(
                                                              "3",
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .white),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Radio(
                                                          activeColor:
                                                              Colors.blue,
                                                          value: "4",
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          groupValue: neoItem,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              neoItem = value;
                                                            });
                                                          },
                                                        ),
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        9,
                                                                    vertical:
                                                                        3),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.blue,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            11)),
                                                            child: const Text(
                                                              "4",
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .white),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Radio(
                                                          activeColor:
                                                              Colors.teal,
                                                          value: "9",
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          groupValue: neoItem,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              neoItem = value;
                                                            });
                                                          },
                                                        ),
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        9,
                                                                    vertical:
                                                                        3),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.teal,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            11)),
                                                            child: const Text(
                                                              "9",
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .white),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Radio(
                                                          activeColor:
                                                              Colors.brown,
                                                          value: "7",
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          groupValue: neoItem,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              neoItem = value;
                                                            });
                                                          },
                                                        ),
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        9,
                                                                    vertical:
                                                                        3),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .brown,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            11)),
                                                            child: const Text(
                                                              "7",
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .white),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Radio(
                                                          activeColor:
                                                              Colors.pink,
                                                          value: "6",
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          groupValue: neoItem,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              neoItem = value;
                                                            });
                                                          },
                                                        ),
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        9,
                                                                    vertical:
                                                                        3),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.pink,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            11)),
                                                            child: const Text(
                                                              "6",
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .white),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Radio(
                                                          activeColor:
                                                              Colors.yellow,
                                                          value: "5",
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          groupValue: neoItem,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              neoItem = value;
                                                            });
                                                          },
                                                        ),
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        9,
                                                                    vertical:
                                                                        3),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .yellow,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            11)),
                                                            child: const Text(
                                                              "5",
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .white),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 3, top: 3),
                                        child: SizedBox(
                                          width: 50,
                                          height: 15,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              11))),
                                              onPressed: () async {
                                                if (neoSelected == 1) {
                                                  await FirebaseService
                                                      .updateMatchWinner(
                                                          FirebaseKey.novel,
                                                          changeMatchIdType(
                                                              matchId, "N"),
                                                          "",
                                                          false,
                                                          true);
                                                }
                                                if (neoSelected == 2) {
                                                  await FirebaseService
                                                      .updateMatchWinner(
                                                          FirebaseKey.novel,
                                                          changeMatchIdType(
                                                              matchId, "N"),
                                                          "",
                                                          false,
                                                          false);
                                                }
                                                if (neoSelected == 3) {
                                                  await FirebaseService
                                                      .updateMatchWinner(
                                                          FirebaseKey.novel,
                                                          changeMatchIdType(
                                                              matchId, "N"),
                                                          neoItem,
                                                          true,
                                                          false);
                                                }
                                              },
                                              child: const Text(
                                                "SET",
                                                style: TextStyle(fontSize: 9),
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              "--: Error :--",
                              style: TextStyle(color: Colors.teal),
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.teal,
                          ),
                        );
                      })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
