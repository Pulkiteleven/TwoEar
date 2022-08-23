import 'dart:math';

import 'package:flutter/material.dart';
import 'package:leloo/AlooActivity.dart';
import 'package:leloo/Mains/cart.dart';
import 'package:leloo/Usefull/Colors.dart';
import 'package:leloo/Usefull/Functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';



class productPage extends StatefulWidget {
  Map<dynamic,dynamic> allData;

  productPage({Key? key,required this.allData}) : super(key: key);

  @override
  State<productPage> createState() => _productPageState();
}

class _productPageState extends State<productPage> {
  bool isHide = false;
  String buyBtntitle = "Buy Now";
  User? user = FirebaseAuth.instance.currentUser;
  Widget mainImg = ClipRRect(borderRadius: BorderRadius.circular(10.0),
  child: Image.asset('asset/icon.png',fit: BoxFit.cover,),);

  @override
  void initState() {
    if(widget.allData['photo'] != null){
      setState((){
        mainImg = ClipRRect(borderRadius: BorderRadius.circular(10.0),
          child: Image(image: CachedNetworkImageProvider(widget.allData['photo']),
            fit: BoxFit.cover,));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: mainYellow,
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
            body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5.0,
                      child: mainImg,
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    children: [
                      mainTextLines(widget.allData['name'], textLight, 20.0, FontWeight.normal, 3),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  mainTextLines(widget.allData['desc'], textLight, 10.0, FontWeight.normal, 6),
                ],
              ),
            ),
            loaderss(isHide, context),

            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(5.0),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  children: [
                    mainText("Price", textLight, 13.0, FontWeight.normal, 1),
                    mainText("₹" + widget.allData['price'].toString(), textColor, 15.0, FontWeight.normal, 1),
                    Spacer(),
                    Colorbtnsss(buyBtntitle, () {BuyNow(); }, mainYellow, textColor),
                  ],
                ),
              ),
            )
        ],
      ),
      ),
    );
  }

  BuyNow() async {
    if(buyBtntitle == "Go to Cart"){
      navScreen(alloActivity(allo:cart()), context, false);
    }
    else {
      setState((){
        isHide = true;
      });
      String userid = user!.uid;
      final databaseReference = FirebaseDatabase.instance.reference();

      String key = generateRandomString(10);
      Map item = widget.allData;
      item['id'] = key;
      Map<String, dynamic> finalItem = {key: item};

      databaseReference.child("userCart/$userid").update(finalItem).then((
          value) =>
      {
        toaster("Product Succesfully Added to Cart"),
        setState(() {
          isHide = false;
          buyBtntitle = "Go to Cart";
        }),
      });
    }
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
