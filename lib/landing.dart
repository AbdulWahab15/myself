import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myself/select_mode.dart';
import 'package:myself/tutorial/tutorials.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing_Screen extends StatefulWidget {
  @override
  _Landing_ScreenState createState() => _Landing_ScreenState();
}

class _Landing_ScreenState extends State<Landing_Screen> {

  bool check = false;
  @override
  void initState() {
    super.initState();
    navigation();
  }

  navigation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    check=prefs.getBool('DontShow');
    Timer(
        Duration(seconds: 3),
            () {

              if(check==null)
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Tutorials()));
              else if(check==true)
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Select_Option()));
    });
  }

  Widget _widget() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
        width: width,
        height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/splash_screen_v2.png'),
              fit: BoxFit.cover
            )
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _widget();
  }
}
