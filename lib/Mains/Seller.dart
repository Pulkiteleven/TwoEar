import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:leloo/Mains/HomeScreen.dart';
import 'package:leloo/Usefull/Colors.dart';
import 'package:leloo/Usefull/Functions.dart';
import 'package:leloo/Usefull/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';




class Seller extends StatefulWidget {
  const Seller({Key? key}) : super(key: key);

  @override
  State<Seller> createState() => _SellerState();
}

class _SellerState extends State<Seller> {
  bool isHide = false;
  bool showPhoto = false;
  String mainName = "";
  String desc = "";
  String cat = "Category";
  int price = 0;
  List<Widget> categorylist = [];
  List<String> allCategories = [];
  final formKey = GlobalKey<FormState>();
  File img = File("");

  @override
  void initState() {
   getCat();
  }

  getCat() async {
    final databaseRef = await FirebaseDatabase.instance.ref('cat');
    databaseRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        print(data);
        if (data != null) {
          for (var x in data.keys) {
            print(x);
            var a = TextButton(onPressed: (){
              setState((){
                cat = x;
              });
            }, child: mainText(x, textColor, 13.0, FontWeight.normal, 1));
            setState((){
              categorylist.add(a);
              allCategories.add(x);
              cat = x;
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: mainYellow,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon:Icon(Icons.arrow_back_outlined,color: Colors.white,),
          ),
          actions: [
            TextButton(onPressed: (){
              UploadProduct();
            }, child: mainText("Sell this Product", textColor, 15.0, FontWeight.normal, 1)),
          ],
        ),

        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0,),
                    mainText("Become a", textColor, 20.0, FontWeight.normal, 1),
                    mainText("Seller", textColor, 30.0, FontWeight.normal, 1),
                    SizedBox(height: 20.0,),

                    mainText("Enter you Product Details", textLight, 15.0, FontWeight.normal, 1),
                    SizedBox(height: 15.0,),

                    TextFormField(
                      minLines: 1,
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                          color: textLight, fontSize: 20.0, fontFamily: 'mons'),
                      decoration: InputDecoration(
                        hintText: "Product Name",
                        // labelText: "Add Title",
                        labelStyle: TextStyle(
                          color: textLight,
                          fontFamily: 'mons',
                          fontSize: 20.0,
                        ),
                        errorStyle: TextStyle(
                          color: errorColor,
                          fontFamily: 'mons',
                          fontSize: 15.0,
                        ),
                      ),
                      onChanged: (text) {
                        mainName = text;
                        print(text);
                      },

                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return ("Please Enter a Name");
                        }
                      }
                    ),

                    SizedBox(height: 15.0,),
                    TextFormField(
                        minLines: 1,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                            color: textLight, fontSize: 20.0, fontFamily: 'mons'),
                        decoration: InputDecoration(
                          hintText: "Description",
                          // labelText: "Add Title",
                          labelStyle: TextStyle(
                            color: textLight,
                            fontFamily: 'mons',
                            fontSize: 20.0,
                          ),
                          errorStyle: TextStyle(
                            color: errorColor,
                            fontFamily: 'mons',
                            fontSize: 15.0,
                          ),
                        ),
                        onChanged: (text) {
                          desc = text;
                          print(text);
                        },

                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return ("Please Enter a Description");
                          }
                        }
                    ),

                    SizedBox(height: 15.0,),
                    TextFormField(
                        minLines: 1,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: textLight, fontSize: 20.0, fontFamily: 'mons'),
                        decoration: InputDecoration(
                          hintText: "Price",
                          // labelText: "Add Title",
                          labelStyle: TextStyle(
                            color: textLight,
                            fontFamily: 'mons',
                            fontSize: 20.0,
                          ),
                          errorStyle: TextStyle(
                            color: errorColor,
                            fontFamily: 'mons',
                            fontSize: 15.0,
                          ),
                        ),
                        onChanged: (text) {
                          price = int.parse(text);
                          print(text);
                        },

                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return ("Please Enter a Price");
                          }
                        }
                    ),


                    SizedBox(height: 15.0,),

                    mainText("Select your product Category", textLight, 15.0, FontWeight.normal, 1),

                    DropdownButton(
                         isExpanded: true,
                         value: cat,
                         icon: Icon(Icons.arrow_downward,color: mainYellow,),
                         items: allCategories.map((String value) {
                           return DropdownMenuItem<String>(
                             value: value,
                             child: mainText(value, textColor, 15.0, FontWeight.normal, 1),
                           );
                         }).toList(),
                         onChanged: (String? value){
                           setState((){
                             cat = value.toString();
                             print(value);
                           });
                         }),

                    mainText("Add Photo", textLight, 15.0, FontWeight.normal, 1),
                    Row(
                      children: [
                        Spacer(),
                        Colorbtnsss("Choose Photo", () {pickPhoto(context); }, mainYellow, textColor),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Row(
                      children: [
                        Spacer(),
                        Visibility(
                            visible: showPhoto,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.50,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.file(
                                    img,
                                    fit: BoxFit.cover,
                                  )),
                            ),),
                        Spacer(),
                      ],
                    )


                  ],
                ),
              ),
            ),

            loaderss(isHide, context),
          ],
        ),
      ),
    );
  }

  chooseCategory(BuildContext context) {
    
    bottomDialog(context, Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categorylist,
    ));
  }

  pickPhoto(BuildContext context) async{
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,);


    if (pickedFile != null) {
      final file = File(pickedFile.path);
      print(file.path);
      cropSquare(File(pickedFile.path), context);
      // uploadFile(file.path, context);
    }
  }
  Future cropSquare(File imageFile,BuildContext context) async {
    CroppedFile? a = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square]);


    setState(() {
      showPhoto = true;
      img = File(a!.path);// circleImage = Image.file(File(a!.path), fit: BoxFit.cover);
      // var b = sendProfilePhoto(a.path, widget.number, context);
      // print(b);
    });
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
  String downUrl = "";

  UploadProduct() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isHide = true;
      });
      if(showPhoto) {
        FirebaseStorage storage = FirebaseStorage.instance;
        String name = img.path
            .split("/")
            .last
            .toString();
        Reference ref = storage.ref("products/$name");
        await ref.putFile(img);
        downUrl = await ref.getDownloadURL();
      }
      var itemKey = generateRandomString(20);

      Map<String, dynamic> mainItem = {
        'name': mainName,
        'price': price,
        'cat': cat,
        'desc':desc,
      };
      if(showPhoto){
        mainItem['photo'] = downUrl;
      }


      Map<String, dynamic> finalItem = {
        itemKey: mainItem,
      };

      final databaseReference = FirebaseDatabase.instance.reference();
      databaseReference.child("products/$cat").update(finalItem).then((value) =>
      {
        toaster("Product Added Succesfully"),
        Navigator.pop(context),
      });
    }
  }

}
