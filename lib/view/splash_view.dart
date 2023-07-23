import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';



class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
    Navigator.pushNamedAndRemoveUntil(context, RoutesName.navigation, (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body:Center(
        child: Center(child: Image.asset('image/findKolkata.png')),
      ),
    );
  }
}
