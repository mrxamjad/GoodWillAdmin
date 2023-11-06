import 'package:clipboard/clipboard.dart';
import 'package:color_wala_admin/Methods/getDateFormate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

Container paymentTransferCard(BuildContext context,
    {String amount = "0",
    bool isRecharge = false,
    String paymentStatus = "pending",
    String userKey = "userKEY",
    String pMethod = "PayTM",
    String pAccount = "XXXXXXXX253",
    // ignore: non_constant_identifier_names
    String TID = "1212154134412",
    String date = "24-Sep-2023"}) {
  Color pColor = Colors.white;
  if (paymentStatus == "pending" || paymentStatus == "Pending") {
    pColor = Colors.orange[400]!;
  }
  if (paymentStatus == "success" || paymentStatus == "Success") {
    pColor = Colors.lightGreen;
  }

  return Container(
    height: 100,
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 0.5, color: Colors.teal)),
    child: Column(
      children: [
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      isRecharge ? "By:" : "To:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          pMethod,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        )),
                        Expanded(
                            child: Text(
                          pAccount,
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 10),
                        ))
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    height: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 1),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.teal[50]),
                                child: SelectableText(
                                  "TID: $TID",
                                  style: const TextStyle(
                                      color: Colors.teal,
                                      fontSize: 8,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 1),
                                child: IconButton(
                                    onPressed: () {
                                      FlutterClipboard.copy(TID);
                                    },
                                    icon: const Icon(
                                      Icons.copy_all,
                                      size: 12,
                                      color: Colors.teal,
                                    )),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 1),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.teal[50]),
                                child: SelectableText(
                                  "USER KEY: $userKey",
                                  style: const TextStyle(
                                      color: Colors.teal,
                                      fontSize: 8,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 1),
                                child: IconButton(
                                    onPressed: () {
                                      FlutterClipboard.copy(userKey);
                                    },
                                    icon: const Icon(
                                      Icons.copy_all,
                                      size: 12,
                                      color: Colors.teal,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(" Amount: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontStyle: FontStyle.normal)),
                      Text(
                        " ₹ $amount",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                  margin:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  decoration: BoxDecoration(
                      color: pColor, borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    paymentStatus,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ))
            ],
          ),
        ),
        if (paymentStatus != "success" && !isRecharge)
          SizedBox(
              height: 25,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => UsePaypal(
                                sandboxMode: false,
                                clientId:
                                    "AbdOfz9UgFddSANVGZiw_-FTFyxMLTBxlxkDN7L2PbGqX1A5F5cWA_KwG9bHckEKnhc-aw4-3GnfZcBL",
                                secretKey:
                                    "EGC-dvcoFXT6OOgrbZ3P9JT1PPbPH9BI8lsFPI9X6Ont9htsAWwqu4T_ZVXnkOailw6XdQJ3uF4-ala7",
                                returnURL: "https://samplesite.com/return",
                                cancelURL: "https://samplesite.com/cancel",
                                transactions: const [
                                  {
                                    "amount": {
                                      "total": '1.0',
                                      "currency": "INR",
                                      "details": {
                                        "subtotal": '1.0',
                                        "shipping": '0',
                                        "shipping_discount": 0
                                      }
                                    },
                                    "description":
                                        "The payment transaction description.",
                                    // "payment_options": {
                                    //   "allowed_payment_method":
                                    //       "INSTANT_FUNDING_SOURCE"
                                    // },
                                    "item_list": {
                                      "items": [
                                        {
                                          "name": "A demo product",
                                          "quantity": 1,
                                          "price": '1.0',
                                          "currency": "INR"
                                        }
                                      ],

                                      // // shipping address is not required though
                                      // "shipping_address": {
                                      //   "recipient_name": "Jane Foster",
                                      //   "line1": "Travis County",
                                      //   "line2": "",
                                      //   "city": "Austin",
                                      //   "country_code": "US",
                                      //   "postal_code": "73301",
                                      //   "phone": "+00000000",
                                      //   "state": "Texas"
                                      // },
                                    }
                                  }
                                ],
                                note:
                                    "Contact us for any questions on your order.",
                                onSuccess: (Map params) async {
                                  print("onSuccess: $params");
                                },
                                onError: (error) {
                                  print("onError: $error");
                                },
                                onCancel: (params) {
                                  print('cancelled: $params');
                                }),
                          ),
                        )
                      },
                  child: const Text(
                    "Pay",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ))),
        if (isRecharge == true)
          SizedBox(
              height: 25,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: paymentStatus == "success"
                          ? Color.fromARGB(255, 224, 80, 54)
                          : Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {},
                  child: Text(
                    paymentStatus == "success" ? "Reject" : "Approve",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ))),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  getDateFormate(date),
                  style: TextStyle(color: Colors.grey[600], fontSize: 8),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
