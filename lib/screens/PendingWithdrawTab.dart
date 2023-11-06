import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_wala_admin/Constrants/FirebaseKey.dart';
import 'package:color_wala_admin/widget/pageBackgroung.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widget/PendingPayment.dart';

class PendingWithdrawTab extends StatefulWidget {
  const PendingWithdrawTab({super.key});

  @override
  State<PendingWithdrawTab> createState() => _PendingWithdrawTabState();
}

class _PendingWithdrawTabState extends State<PendingWithdrawTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pageBackground(),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("withdraw_history")
                .doc("withdraw_pending")
                .collection("withdraw_pending")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("--: Error :--"),
                );
              } else if (snapshot.hasData) {
                List data = [];

                snapshot.data!.docs.map((e) => data.add(e.data())).toList();

                if (!data.isEmpty) {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                          height: 130,
                          child: paymentTransferCard(context,
                              TID: data[index][FirebaseKey.withdrawId],
                              amount: data[index][FirebaseKey.withdrawAmount],
                              date: data[index]
                                  [FirebaseKey.withdrawRequestTime],
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
                    "No pending withdrawal",
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
