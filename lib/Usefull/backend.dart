import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leloo/Mains/HomeScreen.dart';
import 'package:leloo/Usefull/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'Functions.dart';


Map<dynamic,dynamic> mainData = {};
String mainEmail = "";
String name = "";

starthome(BuildContext context) async{
  User? user = await FirebaseAuth.instance.currentUser;


  FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot querySnapshot = await firestore.collection('user')
      .where("email",isEqualTo: user!.email.toString()).get();

  final allData = querySnapshot.docs.map((e) => e.data()).toList();
  var b = allData[0] as Map<String,dynamic>;
  name = b['name'];
  setData(user.email.toString());

  navScreen(homeScreen(allData: b), context, true);
  //Nav screen here

}

setData(String email) async{
  final pref = await SharedPreferences.getInstance();
  await pref.setString("email", email);
}

UpdateProfile(String city,String institute,String course,BuildContext context) async{
  User? user = await FirebaseAuth.instance.currentUser;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Map<String,dynamic> item = {
    "city":city,
    "institute":institute,
    "course":course,
    "joined":DateTime.now().toString(),

  };



  await firestore.collection("user")
      .doc(user!.email)
      .update(item).then((value) => {
    starthome(context),
    toaster("Your Details have been Updated Succesfully"),

  });

}