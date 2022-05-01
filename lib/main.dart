import 'package:flutter/material.dart';
import 'smart contract/contractlinking.dart';
import 'package:provider/provider.dart';
import 'package:pc02/manufacturer.dart';
import 'package:pc02/vendor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_settings/authpage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MaterialApp(home: MyApp(),));
}

// void main(){
//   runApp(
//     MaterialApp(
//       home: MyApp(),
//     )
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //   create: (_) => ContractLink(),
    //   child: MaterialApp(
    //       title: 'Product checker',
    //       home: ManuPage()),
    // );
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.hasError){
            return Center(
              child: Text("Something Went wrong Try Again!!!"),
            );
          }
          else if(snapshot.hasData){
            if(FirebaseAuth.instance.currentUser?.email == "akash@gmail.com"){
              return ChangeNotifierProvider(
                create: (_) => ContractLink(),
                child: MaterialApp(
                    title: 'Product checker',
                    home: ManuPage()),
              );
              // return ManuPage();
            }else{
              return ChangeNotifierProvider(
                create: (_) => ContractLink(),
                child: MaterialApp(
                    title: 'Product checker',
                    home: VendorPage()),
              );
            }
          }else{
            return Authpage();
          }
        },
      );

  }
}
