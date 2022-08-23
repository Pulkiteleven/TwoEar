import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leloo/Auth/ForgetPass.dart';
import 'package:leloo/Auth/Login.dart';
import 'package:leloo/Usefull/backend.dart';
import '../Usefull/Colors.dart';
import '../Usefull/Functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



String name = "";
String email = "";
String password = "";

final _messangerKey = GlobalKey<ScaffoldMessengerState>();


class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
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
                      mainText("SignUp", mainYellow, 40.0, FontWeight.bold, 1),
                      mainText("SignUp to continue", textLight, 13,
                          FontWeight.normal, 1),
                      SizedBox(
                        height: 70.0,
                      ),

                      TextFormField(
                        keyboardType: TextInputType.name,
                        maxLength: 50,
                        style: TextStyle(
                            color: textLight,
                            fontSize: 15.0,
                            fontFamily: 'mons'),
                        decoration: InputDecoration(
                          labelText: "Name",
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
                          name = text;
                        },
                        validator: (value) {
                         if(value!.isEmpty || value == null){
                           return("Please Enter a Name");
                         }
                        },
                      ),

                      SizedBox(height: 15.0,),

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
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        maxLength: 18,
                        style: TextStyle(
                            color: textLight,
                            fontSize: 15.0,
                            fontFamily: 'mons'),
                        decoration: InputDecoration(
                          labelText: "Password",
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
                          password = text;
                        },
                        validator: (value) {
                          if(value!.length < 6){
                            return("password length must be more than 6 letters");
                          }
                        },
                      ),

                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        maxLength: 18,
                        style: TextStyle(
                            color: textLight,
                            fontSize: 15.0,
                            fontFamily: 'mons'),
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
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
                          password = text;
                        },
                        validator: (value) {
                          if(value != password){
                            return("Both Passwords must be same");
                          }
                        },
                      ),

                      SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Colorbtnsss("signup", () {signup(context);}, mainYellow, Colors.white),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          mainText("Already Have an Account?", textColor, 13.0,
                              FontWeight.normal, 1),
                          TextButton(
                              onPressed: () {
                                goLogin();
                              },
                              child: mainText("Login", mainYellow, 13.0,
                                  FontWeight.normal, 1)),
                          Spacer()
                        ],
                      )
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

  void goLogin() {
    navScreen(logIn(), context, true);
  }

  void signup(BuildContext context) {
    if(formKey.currentState!.validate()){
      setState((){
        isHide = true;
      });
      FinalSignUp(context);
    }
  }

  FinalSignUp(BuildContext context) async{
    try{
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password)
          .then((value) => {
        print("blueee" + value.toString()),
        // postDetailstorealtime()
        postDetailsTofirestore(),
      });
    } on FirebaseAuthException catch(e){
      if(e.code == "email-already-in-use"){
        setState((){
          isHide = false;
          snacker("User Already Exists", _messangerKey);
        });
      }
      else{
        isHide = false;
        snacker("Something Went Wrong", _messangerKey);
      }
    }
  }
  postDetailsTofirestore() async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    Map<String,String> item = {
      "name":name,
      "email":email,
    };



    await firestore.collection("user")
        .doc(email)
        .set(item);
    setState((){
      isHide = false;
    });
    toaster("User created Succesfully");
    navScreen(logIn(), context, true);

  }



}
