import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Usefull/Colors.dart';



String email = "";
final _messangerKey = GlobalKey<ScaffoldMessengerState>();


class forgetPassword extends StatefulWidget {
  const forgetPassword({Key? key}) : super(key: key);

  @override
  State<forgetPassword> createState() => _forgetPasswordState();
}

class _forgetPasswordState extends State<forgetPassword> {
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  bool isHide = false;
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      mainText("Forget Password", mainYellow, 40.0, FontWeight.bold, 1),
                      mainText("enter email to continue", textLight, 13,
                          FontWeight.normal, 1),
                      SizedBox(
                        height: 70.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        maxLength: 50,
                        style: TextStyle(
                            color: textLight,
                            fontSize: 15.0,
                            fontFamily: 'mons'),
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: mainYellow,
                            fontFamily: 'mons',
                            fontSize: 15.0,
                          ),
                          errorStyle: TextStyle(
                            color: errorColor,
                            fontFamily: 'mons',
                            fontSize: 15.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mainYellow),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: textColor,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: errorColor,
                            ),
                          ),
                        ),
                        onChanged: (text) {
                          email = text;
                        },
                        validator: (value) {
                          bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!);
                          if (!emailValid) {
                            return ("Please enter a valid email");
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Colorbtnsss("Send Email", () {sendEmail(context);}, mainYellow, Colors.white),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              loaderss(isHide, context),
            ],
          ),
        ),
      ),
    );
  }

  void sendEmail(BuildContext context) {
    if(formKey.currentState!.validate()){
      setState((){
        isHide = true;
      });
      _auth.sendPasswordResetEmail(email: email)
          .then((value) => {
        print(email),
        snacker("Password Reset Mail Send Succesfully", _messangerKey),
        setState((){
          isHide = false;
        })

      });

    }
  }
}
