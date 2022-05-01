import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/services.dart';
import 'dart:convert';




class ScanQR extends StatefulWidget {
  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  String result = '{"name":" ","price":" ","date":" ","place":" "}';
  Future _scanQR() async {
    try {
      String cameraScanResult = await scanner.scan();
      setState(() {
        result = cameraScanResult;
        // setting string result with cameraScanResult
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var dict=json.decode(result);
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Product"),
      ),
      body:  Column(
        children: [
          Container(
            // padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
            padding: EdgeInsets.all(5),
            height: 100,
            width: double.maxFinite,
            child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 15,
                margin: EdgeInsets.all(10),
                child:
                Stack(
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
                      alignment: Alignment.center,
                      child: Text("PRODUCT DETAILS",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                    )
                  ],
                )
            ),

          ),
          Container(
            padding: EdgeInsets.all(5),
            height:500,
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
                              child: Text("Click Scan! To check your Product",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white)) ,
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(10),
                            ),

                            //Name
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(10),
                              child: Text("Product Name:",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white)) ,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(10),
                              child: Text(dict['name'],style: const TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.black)) ,
                            ),


                            //mobile number
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(10),
                              child: Text("Manufactured Date:",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white)) ,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(10),
                              child: Text(dict['date'],style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.black)) ,
                            ),

                            //mail
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(10),
                              child: Text("Product Price:",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white)) ,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(10),
                              child: Text(dict['price'],style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.black)) ,
                            ),


                            //deprtment
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(10),
                              child: Text("Manufactured Location:",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold)) ,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(10),
                              child: Text(dict['place'],style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)) ,
                            ),

                          ],
                        )
                    ),

                  ],
                )
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.camera_alt),
          onPressed: () {
            _scanQR(); // calling a function when user click on button
          },
          label: Text("Scan")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

