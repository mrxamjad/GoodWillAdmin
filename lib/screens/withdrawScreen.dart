import 'package:color_wala_admin/screens/PendingWithdrawTab.dart';
import 'package:color_wala_admin/screens/SuccessWithdrawTab.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';

class WithdrawTab extends StatefulWidget {
  const WithdrawTab({super.key});

  @override
  State<WithdrawTab> createState() => _WithdrawTabState();
}

class _WithdrawTabState extends State<WithdrawTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Withdraw"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SizedBox(
        height: double.infinity,
        child: DefaultTabController(
          length: 2,
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
                        'Pending',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      Tab(
                          child: Text('Success',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  )
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                PendingWithdrawTab(),
                SuccesswithdrawTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
