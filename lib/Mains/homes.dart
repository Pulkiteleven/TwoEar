import 'package:flutter/material.dart';
import 'package:leloo/AlooActivity.dart';
import 'package:leloo/Mains/AllProducts.dart';
import 'package:leloo/Mains/CategoryPage.dart';
import 'package:leloo/Mains/ProductFile.dart';
import 'package:leloo/Mains/category.dart';
import 'package:leloo/Usefull/Colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:leloo/Usefull/Functions.dart';
import 'package:cached_network_image/cached_network_image.dart';

class homes extends StatefulWidget {
  Map<String, dynamic> allData;

  homes({Key? key, required this.allData}) : super(key: key);

  @override
  State<homes> createState() => _homesState();
}

class _homesState extends State<homes> {
  bool isHide = true;
  List<Widget> products = [];
  List<Widget> smallproducts = [];
  List<Widget> categoryItem = [];
  List<Widget> carousal = [];
  Map<dynamic, dynamic> catData = {};
  int counter = 0;

  @override
  void initState() {
    putProducts();
    putCarousal();
  }

  putCarousal() async {
    var a = carousalItems(
        title: "Min 50% off",
        subTitle: "On Marvel Comics",
        bg: mainYellow,
        text: textColor);
    var b = carousalItems(
        title: "Buy Now Harry Potter",
        subTitle: "From WB",
        bg: textColor,
        text: mainYellow);
    var c = carousalItems(
        title: "All DVD from GOT",
        subTitle: "Baccho waala show ni hai",
        bg: mainYellow,
        text: textColor);
    var d = carousalItems(
        title: "Star Wars",
        subTitle: "I am on the high Ground",
        bg: textColor,
        text: mainYellow);

    setState(() {
      carousal.add(a);
      carousal.add(b);
      carousal.add(c);
      carousal.add(d);
    });
  }

  putProducts() async {
    final databaseRef = await FirebaseDatabase.instance.ref('products');
    databaseRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        products = [];
        smallproducts = [];
        if (data != null) {
          setState(() {
            catData = data;
          });

          for (var x in data.keys) {
            var a = categoryItems(data: data[x], title: x);
            setState(() {
              categoryItem.add(a);
            });
          }

          for (var x in data.values) {
            var m = x as Map<dynamic, dynamic>;

            for (var i in m.values) {
              var a = i as Map<dynamic, dynamic>;
              var b = productsitem(data: a);
              setState(() {
                products.add(b);
                if (counter < 4) {
                  setState((){
                    smallproducts.add(b);
                    counter += 1;
                  });
                }
                isHide = false;
              });
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
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0,
              ),
              mainText("Hello", textLight, 10.0, FontWeight.normal, 1),
              mainText(
                  widget.allData['name'], textColor, 25.0, FontWeight.bold, 1),
              SizedBox(
                height: 15.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: carousal,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  mainText(
                      "Our Categories", textLight, 15.0, FontWeight.normal, 1),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        navScreen(
                            alloActivity(allo: category()), context, false);
                      },
                      icon: Icon(Icons.remove_red_eye)),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categoryItem,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  mainText(
                      "Our Products", textLight, 15.0, FontWeight.normal, 1),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        navScreen(
                            allProduct(
                                title: "All Products", allData: products),
                            context,
                            false);
                      },
                      icon: Icon(Icons.remove_red_eye)),
                ],
              ),
              GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 7.0,
                  childAspectRatio: 1.5 / 2,
                ),
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: smallproducts,
              ),
            ],
          ),
        ),
        loaderss(isHide, context)
      ],
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
      setState(() {
        productImage = ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              image: CachedNetworkImageProvider(widget.data['photo']),
              fit: BoxFit.cover,
            ));
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
                padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 0.0),
                child: Column(
                  children: [
                    mainTextLines(widget.data['name'], textColor, 20.0,
                        FontWeight.normal, 1),
                    SizedBox(
                      height: 5.0,
                    ),
                    mainTextLines("₹" + widget.data['price'].toString(),
                        textLight, 15.0, FontWeight.normal, 2),
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

class categoryItems extends StatefulWidget {
  Map<dynamic, dynamic> data;
  String title;

  categoryItems({Key? key, required this.data, required this.title})
      : super(key: key);

  @override
  State<categoryItems> createState() => _categoryItemsState();
}

class _categoryItemsState extends State<categoryItems> {
  Widget productImage = ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: Image.asset(
        'asset/icon.png',
      ));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 140.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        productImage,
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                  mainText(widget.title.toUpperCase(), textColor, 15.0,
                      FontWeight.normal, 1),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        navScreen(
            catPage(title: widget.title, allData: widget.data), context, false);
      },
    );
  }
}

class carousalItems extends StatefulWidget {
  String title;
  String subTitle;
  Color bg;
  Color text;

  carousalItems(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.bg,
      required this.text})
      : super(key: key);

  @override
  State<carousalItems> createState() => _carousalItemsState();
}

class _carousalItemsState extends State<carousalItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.width * 0.45,
      color: transparent_overlay,
      padding: EdgeInsets.only(left: 5.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: widget.bg,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              mainText(widget.title, widget.text, 25.0, FontWeight.bold, 1),
              mainText(
                  widget.subTitle, Colors.white, 10.0, FontWeight.normal, 1),
            ],
          ),
        ),
      ),
    );
  }
}
