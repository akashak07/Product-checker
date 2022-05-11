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
  bool isgenunie=true;



  Future _scanQR() async {
    try {
      String cameraScanResult = await scanner.scan();
      setState(() {
        result = cameraScanResult;
        if (result == "No data to show"){
          MyAlert();
        }
        // setting string result with cameraScanResult
      });
    } on PlatformException catch (e) {
      print(e);
      return MyAlert();

    }
  }
  bool? gcheck(var dict,String name,String date,String place,String price){
    if (dict==null){
      print("no good");
      setState(() {
        isgenunie=true;
      });
    }
    else{
      if(name==null || date==null || price==null || place==null ){
        print("no good");
        setState(() {
          isgenunie=true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var dict=json.decode(result);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          title: Text("Scan-QR",style: TextStyle(color: Colors.white,fontSize: 25),),
          backgroundColor: Colors.black45,
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20)
              )
          ),
        ),
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
          icon: Icon(Icons.qr_code_scanner_rounded),
          onPressed: () {
            _scanQR();

            gcheck(dict, dict['name'], dict['date'], dict['place'], dict['price']);// calling a function when user click on button
          },
          label: Text("Scan QR")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class MyAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: RaisedButton(
        child: Text('Show alert'),
        onPressed: () {
          showAlertDialog(context);
        },
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Simple Alert"),
    content: Text("This is an alert message."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
