import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:leloo/Mains/CategoryPage.dart';
import 'package:leloo/Usefull/Colors.dart';
import 'package:leloo/Usefull/Functions.dart';

class category extends StatefulWidget {

  category({Key? key}) : super(key: key);

  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {

  bool isHide= true;
  List<Widget> catItems = [];
  List<Color> colorsItems = [lightYellow,textLight];
  int _index = 0;

  @override
  void initState() {
    putProducts();
  }

  putProducts() async {
    final databaseRef = await FirebaseDatabase.instance.ref('products');
    databaseRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        if (data != null) {
          for(var x in data.keys){
            var a = categroyItem(title: x, bg: colorsItems[_index], data: data[x]);
            setState((){
              catItems.add(a);
              isHide = false;
            });
            if(_index == 0){
                  _index = 1;
                }
                else{
                  _index = 0;
                }
          }
        }
      } else {
        toaster("No products to Show");
      }
    });
  }






  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0,),
              mainText("Categories", textColor, 25.0, FontWeight.bold, 1),
              SizedBox(height: 15.0,),
              Column(
                children: catItems,
              )
            ],
          ),
        ),
        loaderss(isHide, context),
      ],
    );
  }


}

class categroyItem extends StatefulWidget {
  Map<dynamic,dynamic> data;
  String title;
  Color bg;
  categroyItem({Key? key,required this.title,required this.bg,required this.data}) : super(key: key);

  @override
  State<categroyItem> createState() => _categroyItemState();
}

class _categroyItemState extends State<categroyItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        navScreen(catPage(title: widget.title, allData: widget.data), context, false);
      },

      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 3.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 3.0,
          color: widget.bg,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: mainYellow,
                  child: Icon(Icons.category_outlined, color:Colors.white,size: 30.0),

                ),
                SizedBox(width: 10.0,),
                mainTextLines(widget.title, Colors.white, 20.0, FontWeight.normal, 2),
                Spacer(),

              ],
            ),
          ),

        ),
      ),
    );
  }
}

