import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'camera_page.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Picture Application'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String message = 'By: Jordan Bhar : SN, Nicholas Cammisuli : 991604281';
  File? _image;




  Future onTakePhoto() async{

    try{
      final image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxWidth: 300,
          maxHeight: 300
      );
      if(image ==null) return;

      final imageTemp = File(image.path);
      setState(() {
        _image = imageTemp;
      });


    } on PlatformException catch (e){
      print("failed to pick image: $e");
    }



  }






  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        leading: (IconButton(
          icon: const Icon(
            Icons.home,
          ),
          onPressed: () {},
        )),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(message),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: _image == null ? Image.asset("assets/noimage.png") : Image.file(_image!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onTakePhoto,
                  child: const Text("Take Picture"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: onResetPhoto,
                    child: const Text("Reset Picture"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
