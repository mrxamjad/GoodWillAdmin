import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Data/DataClass.dart';
import 'NavigationBarScreen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 0,
      //   brightness: Brightness.light,
      //   backgroundColor: Colors.white,
      //   leading:
      //   IconButton( onPressed: (){
      //     Navigator.pop(context);
      //   },icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
      // ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/logo1.png',
                    height: 300,
                  )),
            ),
            SizedBox(
              height: 800,
              child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.only(top: 150),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Welcome back!",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 45),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(
                                            color: Colors.black38, width: 0.2)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          " Login ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "with ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "your ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.pink,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "credential",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                makeInput(emailController, label: "Email"),
                                makeInput(passController,
                                    label: "Password", obsureText: true),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              // context.nextPage(HomeScreen());
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                padding: const EdgeInsets.only(top: 3, left: 3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    border: const Border(
                                        bottom: BorderSide(color: Colors.black),
                                        top: BorderSide(color: Colors.black),
                                        right: BorderSide(color: Colors.black),
                                        left: BorderSide(color: Colors.black))),
                                child: MaterialButton(
                                  minWidth: double.infinity,
                                  height: 60,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      try {
                                        final credential = await FirebaseAuth
                                            .instance
                                            .signInWithEmailAndPassword(
                                                email: emailController.text,
                                                password: passController.text);
                                        User? user = credential.user;
                                        String id = user!.uid;

                                        //set user key to DataClass
                                        DataClass.userKey = id;

                                        SharedPreferences pref =
                                            await SharedPreferences
                                                .getInstance();
                                        pref.setString("user_id", id);

                                        // ignore: use_build_context_synchronously
                                        context.nextAndRemoveUntilPage(
                                            const BottomNavigationBarExample());
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'user-not-found') {
                                          context.showToast(
                                              msg:
                                                  "No user found for that email.",
                                              bgColor: Colors.red,
                                              textColor: Colors.white,
                                              position: VxToastPosition.top);
                                        } else if (e.code == 'wrong-password') {
                                          context.showToast(
                                              msg:
                                                  "Wrong password provided for that user.",
                                              bgColor: Colors.red,
                                              textColor: Colors.white,
                                              position: VxToastPosition.top);
                                        } else {
                                          context.showToast(
                                              msg: "Login Failed!.",
                                              bgColor: Colors.red,
                                              textColor: Colors.white,
                                              position: VxToastPosition.top);
                                        }
                                      }
                                    }
                                  },
                                  color: Colors.teal,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget makeInput(TextEditingController controller,
    {label, obsureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.teal),
      ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        controller: controller,
        obscureText: obsureText,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal[400]!,
            ),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$label can't be empty";
          }
          if (obsureText && value.length < 8) {
            return "Password should be  at least 8 length";
          }
          if (!obsureText && !value.contains("@")) {
            return "Please enter a valid mail";
          }
          return null;
        },
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}
