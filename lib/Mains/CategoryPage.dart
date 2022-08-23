import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:leloo/Usefull/Colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Usefull/Functions.dart';
import 'ProductFile.dart';

class catPage extends StatefulWidget {
  String title;
  Map<dynamic,dynamic> allData;
  catPage({Key? key,required this.title,required this.allData}) : super(key: key);

  @override
  State<catPage> createState() => _catPageState();
}

class _catPageState extends State<catPage> {
  List<Widget> catItems = [];


  @override
  void initState() {
    for(var x in widget.allData.values){
      var a = productsitem(data: x);
      setState((){
        catItems.add(a);
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
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0,),
              mainText(widget.title, textColor, 25.0, FontWeight.bold, 1),
              SizedBox(height: 15.0,),
              GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 7.0,
                  childAspectRatio: 1.5/2,
                ),
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: catItems,
              ),
            ],
          ),
        ),
      ),
    );

  }
}

class productsitem extends StatefulWidget {
  Map<dynamic, dynamic> data;

  productsitem({Key? key, required this.data}) : super(key: key);

  @override
  State<productsitem> createState() => _productsitemState();
}

class _productsitemState extends State<productsitem> {
  Widget productImage = ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.asset(
        'asset/icon.png',
        fit: BoxFit.cover,
      ));

  @override
  void initState() {
    if (widget.data['photo'] != null) {
      setState((){
        productImage = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(image: CachedNetworkImageProvider(widget.data['photo']),
              fit: BoxFit.cover,)
        );
      });

    }

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Card(
          elevation: 5.0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              productImage,
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0,vertical: 0.0),
                child: Column(
                  children: [
                    mainTextLines(
                        widget.data['name'], textColor, 20.0, FontWeight.normal, 1),
                    SizedBox(
                      height: 5.0,
                    ),
                    mainTextLines("₹" + widget.data['price'].toString(), textLight,
                        15.0, FontWeight.normal, 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        navScreen(productPage(allData: widget.data), context, false);
      },
    );
  }
}
