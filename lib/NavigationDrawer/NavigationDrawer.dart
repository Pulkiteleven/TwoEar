
import 'package:flutter/material.dart';
import 'package:leloo/AlooActivity.dart';
import 'package:leloo/Auth/Login.dart';
import 'package:leloo/Mains/Seller.dart';
import 'package:leloo/Mains/cart.dart';


import '../Usefull/Colors.dart';
import '../Usefull/Functions.dart';
import 'package:firebase_auth/firebase_auth.dart';



class navigationDrawer extends StatefulWidget {
  Map<String,dynamic> allData;
  navigationDrawer({Key? key,required this.allData})
      : super(key: key);

  @override
  State<navigationDrawer> createState() => _navigationDrawerState();
}

class _navigationDrawerState extends State<navigationDrawer> {
  Image circleImage = logImg(33.0);

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: mainYellow,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildHeder(context),
            buildMenu(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeder(BuildContext context) {
    return DrawerHeader(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 35.0,
                backgroundColor: textColor,
                child: CircleAvatar(
                  radius: 34.0,
                  backgroundColor: mainYellow,
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: ClipOval(
                      child: circleImage,
                    ),
                  ),
                )),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mainText(widget.allData['name'], Colors.white, 25, FontWeight.bold, 1),
                mainTextStars("two ear", Colors.white, 7, FontWeight.bold, 1),
              ],
            ),
            Spacer(),
          ],

        ));
  }

  Widget buildMenu(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [


        ListTile(
          leading: Icon(Icons.shopping_bag_outlined),
          iconColor: textColor,
          visualDensity: const VisualDensity(vertical: -3),
          focusColor: textColor,
          selectedTileColor: textColor,
          selectedColor: textColor,
          title:
          mainTextLeft("Cart", textColor, 13.0, FontWeight.bold, 1),
          onTap: () {
            navScreen(alloActivity(allo: cart()), context, false);
          },
        ),

        ListTile(
          leading: Icon(Icons.monetization_on_outlined),
          iconColor: textColor,
          visualDensity: const VisualDensity(vertical: -3),
          focusColor: textColor,
          selectedTileColor: textColor,
          selectedColor: textColor,
          title:
          mainTextLeft("Become a Seller", textColor, 13.0, FontWeight.bold, 1),
          onTap: () {
            navScreen(Seller(), context, false);
          },
        ),

        Container(width: MediaQuery.of(context).size.width,
          height: 0.2,
          color: textColor,),

        //
        ListTile(
          leading: Icon(Icons.settings_outlined),
          iconColor: textColor,
          visualDensity: const VisualDensity(vertical: -3),
          focusColor: textColor,
          selectedTileColor: textColor,
          selectedColor: textColor,
          title:
          mainTextLeft("Settings", textColor, 13.0, FontWeight.bold, 1),
          onTap: () {
          },
        ),
//
        ListTile(
          leading: Icon(Icons.help_outline),
          iconColor: textColor,
          visualDensity: const VisualDensity(vertical: -3),
          focusColor: textColor,
          selectedTileColor: textColor,
          selectedColor: textColor,
          title:
          mainTextLeft("Help and Feedback", textColor, 13.0, FontWeight.bold, 1),
          onTap: () {
          },
        ),

        ListTile(
          leading: Icon(Icons.update_sharp),
          iconColor: textColor,
          visualDensity: const VisualDensity(vertical: -3),
          focusColor: textColor,
          selectedTileColor: textColor,
          selectedColor: textColor,
          title:
          mainTextLeft("Check For Updates", textColor, 13.0, FontWeight.bold, 1),
          onTap: () {
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          iconColor: textColor,
          visualDensity: const VisualDensity(vertical: -3),
          focusColor: textColor,
          selectedTileColor: textColor,
          selectedColor: textColor,
          title:
          mainTextLeft("Logout", textColor, 13.0, FontWeight.bold, 1),
          onTap: () {
            logOut();
          },
        ),


      ],
    );
  }

  logOut() async {
    final _auth = await FirebaseAuth.instance;
    _auth.signOut().then((value) => {navScreen(logIn(), context, true)});
  }
}

// Future <List<String>> fetchUrl() async{
//   final response = await http.get("https://gefgkerg.com" as Uri);
//
// }
