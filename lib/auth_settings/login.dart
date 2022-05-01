import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Login extends StatefulWidget {
  final VoidCallback onClickedsup;
  const Login({Key? key, required this.onClickedsup}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailcontroller=TextEditingController();
  final pwdcontroller= TextEditingController();

  @override
  void dispose(){
    emailcontroller.dispose();
    pwdcontroller.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    padding: EdgeInsets.fromLTRB(15,50, 0, 0),
                    child:Text('Hello There,',style: TextStyle(color: Colors.black,fontSize: 30,),)
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                    child:Text('Welcome Back!',style: TextStyle(color: Colors.black,fontSize: 30,),)
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: emailcontroller,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: "Enter mail Id"
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: pwdcontroller,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: "Enter Password"
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 10,),

              Padding(padding: EdgeInsets.all(10),
                child: ElevatedButton.icon(onPressed: signin,
                    icon: Icon(Icons.lock_open),
                    label: Text('Log In')
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.all(10),
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      text: "No Account? ",
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer() ..onTap=widget.onClickedsup,
                            text:"Sign Up",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                 fontSize: 20,
                            )
                        )

                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future signin() async{

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: pwdcontroller.text.trim());
    }on FirebaseAuthException catch(e){
      print(e);
    }

  }
}
