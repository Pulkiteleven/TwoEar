import 'package:flutter/material.dart';
import 'package:leloo/Usefull/Colors.dart';

class alloActivity extends StatefulWidget {
  Widget allo;
  alloActivity({Key? key,required this.allo}) : super(key: key);

  @override
  State<alloActivity> createState() => _alloActivityState();
}

class _alloActivityState extends State<alloActivity> {
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
        body: widget.allo,
      ),
    );
  }
}
