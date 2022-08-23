import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leloo/Auth/Login.dart';
import 'package:leloo/Usefull/Colors.dart';
import 'package:leloo/Usefull/backend.dart';
import 'package:lottie/lottie.dart';



import 'Usefull/Functions.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    Future.delayed(Duration(seconds: 4),(){
      checkUser();
    });
  }

  checkUser() async{
    User? user = await FirebaseAuth.instance.currentUser;

    if(user != null){
      print(user.email.toString() + "Batman");
      starthome(context);
    }
    else{
      navScreen(logIn(), context, true);
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              new Container(
                alignment: Alignment.center,
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        mainTextStars("two ear", mainYellow, 20.0, FontWeight.normal, 1)
                      ],
                    ),
                    Lottie.asset('asset/ani.json',
                      width: 90.0,
                      frameRate: FrameRate.max,
                      controller: _controller,
                      repeat: true,
                      alignment: Alignment.center,
                      onLoaded: (composition) {
                        // Configure the AnimationController with the duration of the
                        // Lottie file and start the animation.
                        _controller
                          ..duration = composition.duration
                          ..forward();

                      },),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }


}


