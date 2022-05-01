import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Signup extends StatefulWidget {
  final Function() onClickedsup;
  const Signup({Key? key,required this.onClickedsup}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                    child:Text('Get On Board, as a Client!',style: TextStyle(color: Colors.black,fontSize: 30,),)
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
                child: ElevatedButton.icon(onPressed: signup,
                    icon: Icon(Icons.lock_open),
                    label: Text('Sign Up'),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.all(10),
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      text: "Already have an account! ",
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer() ..onTap=widget.onClickedsup,
                            text:"Log In",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                              fontSize: 20
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
  Future signup() async{

    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: pwdcontroller.text.trim());
    }on FirebaseAuthException catch(e){
      print(e);
    }

  }
}
