import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

class Authpage extends StatefulWidget {
  const Authpage({Key? key}) : super(key: key);

  @override
  _AuthpageState createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  bool isLogin=true;
  @override
  Widget build(BuildContext context) =>
      isLogin
          ? Login(onClickedsup: toggle,)
          : Signup(onClickedsup: toggle);

  void toggle(){
    setState(() {
      isLogin =! isLogin;
    });
  }
}
