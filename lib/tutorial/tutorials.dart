import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myself/select_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tutorials extends StatefulWidget {
  @override
  _TutorialsState createState() => _TutorialsState();
}

class _TutorialsState extends State<Tutorials> {
  Color red = Color(0xff9d0301);

  Widget _widget() {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Carousel(
            images: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/tutorial_1.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text(
                    'Start the app in the home screen',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: red, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/tutorial_2.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text(
                    'Attach the MySelf device on phone\'s\nright side with the hole in contact\nwith the screen',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: red, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/tutorial_3.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text(
                    'Press your finger in the hole for\n3 seconds to adjust the camera\nreview',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: red, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/tutorial_4.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Now touch on the screen or use the\nvolume button to take the picture',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Expanded(
                              child: InkWell(
                                onTap: () async{
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('DontShow',true );
                                  Navigator
                                      .push(context, MaterialPageRoute(builder: (context)=>Select_Option()));
                                },
                                child: Text('DON\'T SHOW AGAIN',textAlign:TextAlign.center,style: TextStyle(color: Colors.white
                                ),),
                              ),
                            ),
                            Container(height: 50, child: VerticalDivider(color: Colors.white)),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left:32.0),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator
                                    .push(context, MaterialPageRoute(builder: (context)=>Select_Option()));
                                  },
                                  child: Text('SKIP',textAlign:TextAlign.center,style: TextStyle(color: Colors.white
                                  ),),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
            boxFit: BoxFit.fitHeight,
            dotColor: Colors.grey,
            indicatorBgPadding: 32.0,
            dotSize: 12.0,
            dotIncreaseSize: 1.01,
            dotBgColor: Colors.purple.withOpacity(0.0),
            dotIncreasedColor: red,
            borderRadius: false,
            moveIndicatorFromBottom: 100,
            dotPosition: DotPosition.topCenter,
            noRadiusForIndicator: true,
            overlayShadow: true,
            overlayShadowColors: Colors.redAccent,
            overlayShadowSize: 0.7,
            autoplay: false,
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
