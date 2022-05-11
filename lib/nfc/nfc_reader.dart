import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'dart:convert';

class ReadExampleScreen extends StatefulWidget {
  @override
  _ReadExampleScreenState createState() => _ReadExampleScreenState();
}

class _ReadExampleScreenState extends State<ReadExampleScreen> {
  StreamSubscription<NDEFMessage>? _stream;
  late String productname=" ";
  late String productprice=" ";
  late String productplace=" ";
  late String productdate=" ";
  StreamSubscription<NDEFMessage>? streams=NFC.readNDEF().listen((NDEFMessage msg) {
    for(NDEFRecord rec in msg.records){
      String? maps=rec.type;
      var map=jsonDecode(maps);
      return map['name'];
    }
  });

  nameset(String name){
    setState(() {
      productname=name;
    });
  }
  priceset(String price){
    setState(() {
      productprice=price;
    });
  }

  dateset(String date){
    setState(() {
      productdate=date;
    });
  }

  placeset(String place){
    setState(() {
      productplace=place;
    });
  }

  pay(String map){
    var st=jsonDecode(map);
    return st;
  }


  _startScanning() {
    setState(() {
      _stream = NFC
          .readNDEF(alertMessage: "Custom message with readNDEF#alertMessage")
          .listen((NDEFMessage message) {
        if (message.isEmpty) {
          print("Read empty NDEF message");
          return;
        }
        print("Read NDEF message with ${message.records.length} records");


        for (NDEFRecord record in message.records ) {
          print(
              "Record '${record.id ?? "[NO ID]"}' with TNF '${record.tnf}', type '${record.type}', payload '${record.payload}' and data '${record.data}' and language code '${record.languageCode}'");
          print('${record.type}');
          pay('${record.type}');
          var st=jsonDecode('${record.type}');
          var n=st['name'];
          var p=st['price'];
          var pp=st['place'];
          var d=st['date'];
          print(n);
          print(p);
          print(pp);
          print(d);
          nameset(n);
          dateset(d);
          placeset(pp);
          priceset(p);
        }
      }, onError: (error) {
        setState(() {
          _stream = null;
        });
        if (error is NFCUserCanceledSessionException) {
          print("user canceled");
        } else if (error is NFCSessionTimeoutException) {
          print("session timed out");
        } else {
          print("error: $error");
        }
      }, onDone: () {
        setState(() {
          _stream = null;
        });
      });
    });
  }

  void _stopScanning() {
    _stream?.cancel();
    setState(() {
      _stream = null;
    });
  }

  void _toggleScan() {
    return _startScanning();
  }

  @override
  void dispose() {
    super.dispose();
    _stopScanning();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          title: Text("Scan-NFC",style: TextStyle(color: Colors.white,fontSize: 25),),
          backgroundColor: Colors.black45,
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20)
              )
          ),
        ),
      ),
      body: Column(
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
            height:450,
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
                              child: Text(productname,style: const TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.black)) ,
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
                              child: Text(productdate,style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.black)) ,
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
                              child: Text(productprice,style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.black)) ,
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
                              child: Text(productplace,style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)) ,
                            ),

                            // Container(
                            //   alignment: Alignment.topLeft,
                            //   padding: EdgeInsets.all(10),
                            //   child: Text("Product Genunity:",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold)) ,
                            // ),
                            // Container(
                            //   alignment: Alignment.topLeft,
                            //   padding: EdgeInsets.all(10),
                            //   child: Text(isgenunie==false ? "no Good" : " Good",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)) ,
                            // ),
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
          icon: Icon(Icons.phonelink_ring_outlined),
          onPressed: () {
           _toggleScan();
          },
          label: Text("Scan NFC"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}