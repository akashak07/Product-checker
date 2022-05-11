import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../smart contract/contractlinking.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class QrWrite extends StatefulWidget {
  @override
  _QrWriteState createState() => _QrWriteState();
}

class _QrWriteState extends State<QrWrite> {

  String qrData = "No data to show";
  var qrdataFeed;
  var thelist=<Map>[];
  var thedict=new Map();
  late File _imageFile;
  GlobalKey _globalKey = new GlobalKey();
  late Uint8List imageInMemory;
  late String imagePath;
  late File capturedFile;

  TextEditingController nameController=new TextEditingController();
  TextEditingController priceontroller=new TextEditingController();
  TextEditingController locationController=new TextEditingController();
  TextEditingController dateController=new TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();




  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLink>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          title: Text("Qr-Code",style: TextStyle(color: Colors.white,fontSize: 25),),
          backgroundColor: Colors.black45,
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20)
              )
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: contractLink.isLoading
          ? const CircularProgressIndicator()
          :SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  height:700,
                  width: double.maxFinite,
                  child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 15,
                      margin: EdgeInsets.all(10),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    stops: [
                                      0.060,
                                      0.4,
                                      0.6,
                                      0.9
                                    ],
                                    colors: [
                                      Colors.purple,
                                      Colors.red,
                                      Colors.indigo,
                                      Colors.teal
                                    ])),
                          ),
                          Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Text("Enter Product Data To Generate Qr-Code",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white)) ,
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.all(10),
                                  ),

                                  //Name
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.all(10),
                                    child: Text("Product Name",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white)) ,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      margin: EdgeInsets.all(1),
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Product Name",
                                              hintStyle: TextStyle(color: Colors.grey[400],
                                              )
                                          ),
                                          controller: nameController,
                                        ),
                                      ),
                                    ),
                                  ),

                                  //mobile number
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.all(10),
                                    child: Text("Manufactured Date",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white)) ,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      margin: EdgeInsets.all(1),
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Manufactured Date",
                                              hintStyle: TextStyle(color: Colors.grey[400])
                                          ),
                                          controller:dateController,
                                        ),
                                      ),
                                    ),
                                  ),

                                  //mail
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.all(10),
                                    child: Text("Enter Price",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white)) ,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      margin: EdgeInsets.all(1),
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Price",
                                              hintStyle: TextStyle(color: Colors.grey[400])
                                          ),
                                          controller:priceontroller,
                                        ),
                                      ),
                                    ),
                                  ),

                                  //deprtment
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.all(10),
                                    child: Text("Enter Location",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold)) ,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      margin: EdgeInsets.all(1),
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Manufactured Location",
                                              hintStyle: TextStyle(color: Colors.grey[400])
                                          ),
                                          controller: locationController,
                                        ),
                                      ),
                                    ),
                                  ),

                                  //button
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 35, 10, 0),
                                    child: ElevatedButton(
                                      child: Text("Click To save data in blockchain",style: TextStyle(fontSize: 18),),
                                      onPressed: () async{
                                        await contractLink.addname(nameController.text);

                                        await contractLink.addlocation(locationController.text);

                                        await contractLink.addprice(priceontroller.text);

                                        await contractLink.adddate(dateController.text);

                                        thedict["name"]=nameController.text;
                                        thedict["price"]=priceontroller.text;
                                        thedict["date"]=dateController.text;
                                        thedict["place"]=locationController.text;
                                        qrdataFeed=json.encode(thedict);
                                        print(thedict);
                                        print(qrdataFeed.toString());
                                        if (qrdataFeed.toString().isEmpty) {        //a little validation for the textfield
                                          setState(() {
                                            qrData = "";
                                          });
                                        } else {
                                          setState(() {
                                            qrData = qrdataFeed.toString();
                                          });
                                        }
                                        nameController.clear();
                                        locationController.clear();
                                        priceontroller.clear();
                                        dateController.clear();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        onPrimary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),

                        ],
                      )
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   Screenshot(
                      controller: screenshotController,
                      // key: _globalKey,
                      child: Container(
                        alignment: Alignment.center,
                        height: 250,
                        // width: 250,
                        padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(1),
                          child: QrImage(
                            data:qrData
                          )
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      width:100,
                      // width: 250,
                      padding: EdgeInsets.all(0),
                      child: FlatButton(onPressed: () async{
                        final image= await screenshotController.capture();
                        if (image==null){
                          print("errorrrrr!!!!!!!");
                          return;
                        }
                        await saveImage(image);
                      }, child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text("Save \nQr-Code\nTo gallery"),
                      ),color: Colors.redAccent,)
                    ),
                  ],
                )
              ],
            ),
          ),
        ),

      ),
    );
  }


    Future<String> saveImage(Uint8List bytes) async{
    await [Permission.speech].request();

    final time=DateTime.now().toIso8601String().replaceAll('.', '-').replaceAll(':', '-');
    final name='qr-code_$time';

     final result= await ImageGallerySaver.saveImage(bytes,name: name);
     return result['filepath'];
    }

}



