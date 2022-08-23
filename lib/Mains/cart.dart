
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leloo/Mains/homes.dart';
import 'package:leloo/Usefull/Colors.dart';

  class cart extends StatefulWidget {
    const cart({Key? key}) : super(key: key);
  
    @override
    State<cart> createState() => _cartState();
  }
  
  class _cartState extends State<cart> {
    User? users = FirebaseAuth.instance.currentUser;
    bool isHide = true;
    User? user = FirebaseAuth.instance.currentUser;
    List<Map<dynamic,dynamic>> products = [];
    List<Widget> carts = [];


    @override
  void initState() {
      getData();
  }

  getData() async{
      String key = user!.uid;
    final databaseRef = await FirebaseDatabase.instance.ref('userCart/$key');
    databaseRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        print(data);
        if (data != null) {
          products = [];
          carts = [];
          for (var x in data.values) {
            var a = x as Map<dynamic, dynamic>;
            var b = cartItems(data: a);
            setState(() {
              carts.add(b);
              products.add(a);
              isHide = false;
            });
          }
        }
      } else {
        toaster("No products to Show");
      }
    });
  }

  @override
    Widget build(BuildContext context) {
      return Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0,),
                mainText("Cart", textColor, 25.0, FontWeight.bold, 1),
                SizedBox(height: 15.0,),
                Column(
                  children: carts,
                )
              ],
            ),
          ),
          loaderss(isHide, context),
        ],
      );
    }
  }

  class cartItems extends StatefulWidget {
    Map<dynamic,dynamic> data;
    cartItems({Key? key,required this.data}) : super(key: key);

    @override
    State<cartItems> createState() => _cartItemsState();
  }

  class _cartItemsState extends State<cartItems> {
    User? user = FirebaseAuth.instance.currentUser;
    Color bg = lightYellow;
    String btntitle = "Pay Now";
    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 3.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 3.0,
          color: bg,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: mainYellow,
                  child: Icon(Icons.shopping_bag_outlined,color: Colors.white,),

                ),
                SizedBox(width: 10.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mainTextLines(widget.data['name'], textColor, 15.0, FontWeight.normal, 2),
                    mainTextLines("₹" + widget.data['price'].toString(), textLight, 13.0, FontWeight.normal, 1),

                  ],
                ),
                Spacer(),
                Column(
                  children: [
                Colorbtnsss(btntitle, () {payNow(); }, textLight, Colors.white),
                Colorbtnsss("Remove", () { remove();}, mainYellow, Colors.white),
                  ],
                )
              ],
            ),
          ),

        ),
      );
    }

  void remove() {
      var x = user!.uid;
      final ref = FirebaseDatabase.instance.reference();
      ref.child("userCart/$x").child(widget.data['id']).remove().then((value) => {
        toaster("Order Removed Succesfully from Cart"),
      });
  }
  }

void payNow() {
}

  
  