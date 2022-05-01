import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'dart:convert';

class GeneratePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage> {
  String qrData =
      "https://github.com/neon97";  // already generated qr code when the page opens
  TextEditingController name=new TextEditingController();
  TextEditingController price=new TextEditingController();
  TextEditingController date=new TextEditingController();
  TextEditingController location=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              QrImage(
                //plce where the QR Image will be shown
                data: qrData,
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "New QR Link Generator",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Enter product name:",
                ),
              ),
              TextField(
                controller: price,
                decoration: InputDecoration(
                  hintText: "Enter price",
                ),
              ),
              TextField(
                controller: date,
                decoration: InputDecoration(
                  hintText: "date",
                ),
              ),
              TextField(
                controller: location,
                decoration: InputDecoration(
                  hintText: "Location",
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                child: FlatButton(
                  padding: EdgeInsets.all(15.0),
                  onPressed: () async {
                    thedict["name"]=name.text;
                    thedict["price"]=price.text;
                    thedict["date"]=date.text;
                    thedict["place"]=location.text;
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


                  },
                  child: Text(
                    "Generate QR",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue, width: 3.0),
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }

  var qrdataFeed;
  var thelist=<Map>[];
  var thedict=new Map();

}