import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'smart contract/contractlinking.dart';
import 'qr/qrcode_write.dart';
import 'package:pc02/qr/scan_qr.dart';
import 'nfc/nfc_record_form.dart';
import 'package:pc02/manufacturer.dart';
import 'qr/dummy_qr_scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pc02/auth_settings/authpage.dart';


class VendorPage extends StatefulWidget {
  const VendorPage({Key? key}) : super(key: key);

  @override
  State<VendorPage> createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {

  }
  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLink>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(25, 30, 0, 0),
                      child:CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 21,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/dp.jpg'),
                        ),
                      )

                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 30, 0, 0),
                    child: Text("Hello! ",style: TextStyle(fontSize: 25),),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 30, 0, 0),
                    child: Text("Welcome",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child:  Container(
                // padding: EdgeInsets.fromLTRB(10, 3, 10, 10),
                padding: EdgeInsets.all(5),
                height: 220,
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
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage('assets/qr.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: new BackdropFilter(
                            filter: new ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                            child: new Container(
                              decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Text('QR-Code',style: TextStyle(fontSize: 40,color: Colors.black,fontWeight: FontWeight.bold),),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                  alignment: Alignment.bottomRight,
                                  child:
                                  ElevatedButton(
                                    child: Text("Click Here"),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ScanQR()),
                                      );

                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      onPrimary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32.0),
                                      ),
                                    ),
                                  )
                              ),
                            ),

                          ],
                        )
                      ]
                  ),
                  // Container(
                  //   height: 10,
                  //   width: double.maxFinite,
                  //   color: Colors.white,
                  // )
                ),
              ),
            ),


            // Padding(
            //   padding: EdgeInsets.all(15),
            //   child:  Container(
            //     // padding: EdgeInsets.fromLTRB(10, 3, 10, 10),
            //     padding: EdgeInsets.all(5),
            //     height: 220,
            //     width: double.maxFinite,
            //     child: Card(
            //       semanticContainer: true,
            //       clipBehavior: Clip.antiAliasWithSaveLayer,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.0),
            //       ),
            //       elevation: 15,
            //       margin: EdgeInsets.all(10),
            //       child:
            //       Stack(
            //           children: <Widget>[
            //             Container(
            //               decoration: new BoxDecoration(
            //                 image: new DecorationImage(
            //                   image: new AssetImage('assets/nfc.jpg'),
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //               child: new BackdropFilter(
            //                 filter: new ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            //                 child: new Container(
            //                   decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
            //                 ),
            //               ),
            //             ),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Padding(
            //                   padding: EdgeInsets.all(15),
            //                   child: Container(
            //                     alignment: Alignment.bottomLeft,
            //                     child: Text('NFC',style: TextStyle(fontSize: 40,color: Colors.black,fontWeight: FontWeight.bold),),
            //                   ),
            //                 ),
            //
            //                 Padding(
            //                   padding: const EdgeInsets.all(15.0),
            //                   child: Container(
            //                       alignment: Alignment.bottomRight,
            //                       child:
            //                       ElevatedButton(
            //                         child: Text("Click Here"),
            //                         onPressed: () {
            //                           Navigator.push(
            //                             context,
            //                             MaterialPageRoute(builder: (context) => Dummy()),
            //                           );
            //
            //                         },
            //                         style: ElevatedButton.styleFrom(
            //                           primary: Colors.red,
            //                           onPrimary: Colors.white,
            //                           shape: RoundedRectangleBorder(
            //                             borderRadius: BorderRadius.circular(32.0),
            //                           ),
            //                         ),
            //                       )
            //                   ),
            //                 ),
            //
            //               ],
            //             )
            //           ]
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await auth.signOut();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Authpage()));
        },
        child: Icon(Icons.logout_rounded),
        backgroundColor: Colors.redAccent,
      ),
    );

  }
}




