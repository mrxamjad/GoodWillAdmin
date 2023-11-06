import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Constrants/FirebaseKey.dart';
import '../widget/PendingPayment.dart';
import '../widget/pageBackgroung.dart';

class PendingRechargeTab extends StatefulWidget {
  const PendingRechargeTab({super.key});

  @override
  State<PendingRechargeTab> createState() => _PendingRechargeTabState();
}

class _PendingRechargeTabState extends State<PendingRechargeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pageBackground(),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("recharge_history")
                .orderBy(
                  "request_time",
                  descending: true,
                )
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("--: Error :--"),
                );
              } else if (snapshot.hasData) {
                List data = [];

                snapshot.data!.docs.map((e) {
                  if (e.data()["status"] != "success") data.add(e.data());
                }).toList();
                if (!data.isEmpty) {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                          height: 130,
                          child: paymentTransferCard(context,
                              isRecharge: true,
                              TID: data[index][FirebaseKey.rechargeId],
                              amount: data[index][FirebaseKey.rechargeAmount]
                                  .toString(),
                              date: data[index]
                                  [FirebaseKey.rechargeRequestTime],
                              pAccount: data[index][FirebaseKey.bankAccount],
                              pMethod: data[index][FirebaseKey.paymentMethod],
                              paymentStatus: data[index]
                                  [FirebaseKey.withdrawStatus],
                              userKey: data[index][FirebaseKey.userKey]));
                    },
                  );
                } else {
                  return const Center(
                      child: Text(
                    "No pending recharge",
                    style: TextStyle(
                        color: Colors.teal, fontStyle: FontStyle.italic),
                  ));
                }
              }

              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
