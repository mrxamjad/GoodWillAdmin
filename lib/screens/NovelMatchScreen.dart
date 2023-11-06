import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_wala_admin/widget/pageBackgroung.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Constrants/FirebaseKey.dart';
import '../widget/duoMatchWidget.dart';
import '../widget/neoMatchWidget.dart';
import '../widget/trioMatchWidget.dart';

class NovelMatchScreen extends StatefulWidget {
  const NovelMatchScreen({super.key});

  @override
  State<NovelMatchScreen> createState() => _NovelMatchScreenState();
}

class _NovelMatchScreenState extends State<NovelMatchScreen> {
  String matchCategory = "NOVEL";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        pageBackground(
            fistBoxColor: Colors.teal,
            flex: 3,
            secondBoxColor: Colors.grey[200]!),
        FutureBuilder(
          future: FirebaseFirestore.instance
              .collection(FirebaseKey.matchHistory)
              .doc(FirebaseKey.novel)
              .collection(FirebaseKey.novel)
              .orderBy("start_date", descending: true)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List dataList = [];
              snapshot.data!.docs.map((e) {
                dataList.add(e.data());
                // print(e.data().toString());
              }).toList();

              // if (dataList.isEmpty) {
              //   return const Center(
              //     child: Text("--: No data :--"),
              //   );
              // } else {
              print(dataList.toString());
              return ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  String matchType = dataList[index][FirebaseKey.matchType];
                  if (matchType == "duo") {
                    return duoMatchWidget(
                      matchCategory,
                      dataList[index][FirebaseKey.redJoinee],
                      dataList[index][FirebaseKey.greenJoinee],
                      dataList[index][FirebaseKey.redAmount],
                      dataList[index][FirebaseKey.greenAmount],
                      dataList[index][FirebaseKey.matchId],
                      dataList[index][FirebaseKey.matchStartDate],
                    );
                  } else if (matchType == "trio") {
                    return trioMatchWidget(
                      matchCategory,
                      dataList[index][FirebaseKey.blueJoinee],
                      dataList[index][FirebaseKey.purpleJoinee],
                      dataList[index][FirebaseKey.pinkJoinee],
                      dataList[index][FirebaseKey.blueAmount],
                      dataList[index][FirebaseKey.purpleAmount],
                      dataList[index][FirebaseKey.pinkAmount],
                      dataList[index][FirebaseKey.matchId],
                      dataList[index][FirebaseKey.matchStartDate],
                    );
                  } else {
                    return neoMatchWidget(
                      matchCategory,
                      dataList[index][FirebaseKey.oneJoinee],
                      dataList[index][FirebaseKey.twoJoinee],
                      dataList[index][FirebaseKey.threeJoinee],
                      dataList[index][FirebaseKey.fourJoinee],
                      dataList[index][FirebaseKey.fiveJoinee],
                      dataList[index][FirebaseKey.sixJoinee],
                      dataList[index][FirebaseKey.sevenJoinee],
                      dataList[index][FirebaseKey.eightJoinee],
                      dataList[index][FirebaseKey.oneAmount],
                      dataList[index][FirebaseKey.twoAmount],
                      dataList[index][FirebaseKey.threeAmount],
                      dataList[index][FirebaseKey.fourAmount],
                      dataList[index][FirebaseKey.fiveAmount],
                      dataList[index][FirebaseKey.sixAmount],
                      dataList[index][FirebaseKey.sevenAmount],
                      dataList[index][FirebaseKey.eightAmount],
                      dataList[index][FirebaseKey.matchId],
                      dataList[index][FirebaseKey.matchStartDate],
                    );
                  }
                },
              );
              // }
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("--: Error :--"),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            );
          },
        )
      ],
    );
  }
}
