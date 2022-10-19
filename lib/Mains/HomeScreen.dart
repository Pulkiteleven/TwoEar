import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:leloo/Mains/cart.dart';
import 'package:leloo/Mains/category.dart';
import 'package:leloo/Mains/homes.dart';
import 'package:leloo/Usefull/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

import '../NavigationDrawer/NavigationDrawer.dart';


final _messangerKey = GlobalKey<ScaffoldMessengerState>();

final GlobalKey<ScaffoldState> _key = GlobalKey();
// Create a key

class homeScreen extends StatefulWidget {
  Map<String, dynamic> allData;

  homeScreen({Key? key,required this.allData})
      : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  String name = "";
  bool isHide = false;
  int currentIndex = 0;
  Map<dynamic,dynamic> mainData = {};

  List bottomItems = [];

  Widget navButton = Icon(
    Icons.sort,
    size: 25.0,
    color: mainYellow,
  );


  @override
  void initState() {
    // getName();

    setState(() {
      name = widget.allData['name'];
    });

    bottomItems = [
      homes(allData: widget.allData),
      category(),
      cart(),
      homes(allData: widget.allData),

    ];
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        titleTextStyle: TextStyle(
          fontFamily: 'mons',
          fontSize: 15.0,
          color: textColor
        ),
        contentTextStyle: TextStyle(
            fontFamily: 'mons',
            fontSize: 13.0,
            color: textColor
        ),
        alignment: Alignment.bottomCenter,
        backgroundColor: mainYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No',style: TextStyle(color: Colors.white,fontFamily: 'mons'),),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes',style: TextStyle(color: Colors.white,fontFamily: 'mons'),),
          ),
        ],
      ),
    )) ?? false;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          key: _key,
          backgroundColor: Colors.white,
          drawer: navigationDrawer(
            allData: widget.allData,
          ),
          appBar:AppBar(
            backgroundColor: mainYellow,
            elevation: 0,
          ),
          bottomNavigationBar: FlashyTabBar(
            backgroundColor: Colors.white,
            onItemSelected: (int val) => setState(() => currentIndex = val),
            selectedIndex: currentIndex,
            items: [
              FlashyTabBarItem(
                icon: Icon(
                  Icons.home,
                  color: mainYellow,
                ),
                title:
                mainText("Home", mainYellow, 15.0, FontWeight.normal, 1),
              ),
              FlashyTabBarItem(
                icon: Icon(
                  Icons.category,
                  color: mainYellow,
                ),
                title: mainText(
                    "Categories", mainYellow, 15.0, FontWeight.normal, 1),
              ),
              FlashyTabBarItem(
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: mainYellow,
                ),
                title: mainText(
                    "Cart", mainYellow, 15.0, FontWeight.normal, 1),
              ),
              FlashyTabBarItem(
                icon: Icon(
                  Icons.account_circle,
                  color: mainYellow,
                ),
                title: mainText(
                    "Profile", mainYellow, 15.0, FontWeight.normal, 1),
              ),
            ],
          ),
          body: bottomItems.elementAt(currentIndex),
        ),
      ),
    );
  }


  void learnAnalysis() {
    print("Learning Analysis");
  }
}
