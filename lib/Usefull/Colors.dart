import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';



Color mainYellow = Color(0xFFFF9900);
Color textColor = Color(0xFF404040);
Color textLight = Color(0xFF5E5E5E);
Color errorColor = Color(0xFFFF0051);
Color transparent_overlay = Color(0xFFFFFF);
Color lightYellow = Color(0xFFFFB47D);

Color itemColor = Color(0xFFDEDEDE);

Text mainText(String text, Color c, double size, FontWeight w,int lines) {
  return Text(
    text,
    textAlign: TextAlign.center,
    maxLines: lines,
    style: TextStyle(
      color: c,
      letterSpacing: 0.5,
      fontSize: size,
      fontFamily: 'mons',
      fontWeight: w,

    ),
  );
}

Text mainTextStars(String text, Color c, double size, FontWeight w,int lines) {
  return Text(
    text,
    textAlign: TextAlign.center,
    maxLines: lines,
    style: TextStyle(
      color: c,
      letterSpacing: 0.5,
      fontSize: size,
      fontFamily: 'star',
      fontWeight: w,

    ),
  );
}


AutoSizeText mainTextLines(String text, Color c, double size, FontWeight w,int lines) {
  return AutoSizeText(
    text,
    textAlign: TextAlign.start,
    maxLines: lines,
    style: TextStyle(
      color: c,
      letterSpacing: 0.5,
      fontSize: size,
      fontFamily: 'mons',
      fontWeight: w,

    ),
  );
}

Text mainTextLeft(String text, Color c, double size, FontWeight w,int lines) {
  return Text(
    text,
    textAlign: TextAlign.start,
    maxLines: lines,
    style: TextStyle(
      color: c,
      letterSpacing: 0.5,
      fontSize: size,
      fontFamily: 'mons',
      fontWeight: w,

    ),
  );
}

Image logImg(double x){
  return Image(
    image: const AssetImage('asset/icon.png'),
    width: x,
    height: x,
  );
}

class Colorbtnsss extends StatelessWidget {
  final VoidCallback callback;
  final String title;
  final Color bg;
  final Color textbg;

  const Colorbtnsss(this.title,this.callback,this.bg,this.textbg);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
        child: mainText(
            title, textbg, 13.0, FontWeight.normal,1),
      ),
      style: ButtonStyle(
          foregroundColor:
          MaterialStateProperty.all<Color>(
              bg),
          backgroundColor:
          MaterialStateProperty.all<Color>(bg),
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0),
                  side: const BorderSide(color: Colors.white)))),
      onPressed: callback,
    );
  }
}


class loader extends StatelessWidget {
  const loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: new Container(
        height: 90.0,
        width: 90.0,
        child: new Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
          elevation: 7.0,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              color: mainYellow,
              strokeWidth: 5,
            ),
          ),
        ),
      ),
    );
  }
}

Widget loaderss(bool a,BuildContext context){
  return Visibility(
      visible: a,
      child: Stack(
        children: [
          Visibility(
            visible: a,
            child: new Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: new Card(
                color: transparent_overlay,
                elevation: 0.0,
              ),
            ),
          ),
          Visibility(visible: a, child: loader())
        ],
      ));
}

void snackerc(String title, BuildContext context){

  ScaffoldMessenger.of(context).showSnackBar(SnackBar
    (content: mainTextLeft(title, textColor, 15.0, FontWeight.normal, 2),
    backgroundColor: mainYellow,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3.0),
    ),
  ));
}


void snacker(String title, GlobalKey<ScaffoldMessengerState> aa){

  aa.currentState!.showSnackBar(SnackBar
    (content: mainTextLeft(title, textColor, 15.0, FontWeight.normal, 2),
    backgroundColor: mainYellow,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3.0),
    ),
  ));
}

toaster(String msg){
  Fluttertoast.showToast(msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: mainYellow);

}

bottomDialog(BuildContext context,Widget w){
  showMaterialModalBottomSheet(
      context: context,
      builder: (context) => w
  );
}

