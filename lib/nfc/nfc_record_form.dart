import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../smart contract/contractlinking.dart';
import 'nfc_reader.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'dart:async';
import 'dart:io';


class Records{
  late String data;
  late String payload;
}


class RecordFormPage extends StatefulWidget {
  @override
  _RecordFormPageState createState() => _RecordFormPageState();
}

class _RecordFormPageState extends State<RecordFormPage> {
  StreamSubscription<NDEFMessage>? _stream;
  List<Records> _records = [];
  bool _hasClosedWriteDialog = false;
  late String out;
  TextEditingController name=new TextEditingController();
  TextEditingController price=new TextEditingController();
  TextEditingController date=new TextEditingController();
  TextEditingController location=new TextEditingController();

  void _addrecord(){
    setState(() {
      _records.add(Records());
    });
  }

  void _write(BuildContext context) async{
    List<NDEFRecord> records = _records.map((record){
      return NDEFRecord.type(
        record.data=out,
        record.payload="Text",
      );
    }).toList();
    NDEFMessage message = NDEFMessage.withRecords(records);

    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Scan the tag you want to write to"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                _hasClosedWriteDialog = true;
                _stream?.cancel();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
    await NFC.writeNDEF(message).first;
    if (!_hasClosedWriteDialog) {
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLink>(context);
    return Scaffold(
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
                  height:800,
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
                                    child: Text("Enter Product Data To Save Data in NFC-Tag",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white)) ,
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
                                          controller: name,
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
                                          controller:date,
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
                                          controller:price,
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
                                          controller: location,
                                        ),
                                      ),
                                    ),
                                  ),

                                  //button
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 35, 10, 0),
                                    child: ElevatedButton(
                                      child: Text("Click To store data in blockchain",style: TextStyle(fontSize: 18),),
                                      onPressed: () async{
                                        await contractLink.addname(name.text);
                                        await contractLink.addlocation(location.text);
                                        await contractLink.addprice(price.text);
                                        await contractLink.adddate(date.text);
                                        var n=name.text;
                                        var pr=price.text;
                                        var pd=date.text;
                                        var pl=location.text;

                                        out='{"name":"$n","price":"$pr","date":"$pd","place":"$pl"}';
                                        print(out);
                                        _addrecord();
                                        _records.length > 0 ? () => _write(context) : null;

                                        name.clear();
                                        location.clear();
                                        price.clear();
                                        date.clear();

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

                          // Container(
                          //   child: Text("Please Wait Patiently! Once Data is Stored\nIt redirect's you to save data to NFC Tag!",style: TextStyle(fontSize: 20,color: Colors.white)) ,
                          //   alignment: Alignment.bottomCenter,
                          //   padding: EdgeInsets.all(10),
                          // ),

                        ],
                      )
                  ),
                ),

              ],
            ),
          ),
        ),

      ),
    );
  }
}
