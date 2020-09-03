import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'capture.dart';

class Select_Option extends StatefulWidget {
  @override
  _Select_OptionState createState() => _Select_OptionState();
}

class _Select_OptionState extends State<Select_Option> {

  Widget _widget(){
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:32.0),
                    child: Text('Select the Option:',style: TextStyle(color: Colors.amber,fontSize: 25),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Image.asset('images/botao_foto.png',width: 80,),
                        onTap: (){
                          Fluttertoast.showToast(
                              msg: 'Thank you. You have set Photo as default option. You can change this whenever you want.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Capture(1)));

                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:32.0),
                        child: GestureDetector(
                          child: Image.asset('images/botao_filmar.png',width: 80),
                          onTap: (){
                            Fluttertoast.showToast(
                                msg: 'Thank you. You have set Video as default option. You can change this whenever you want.',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white
                            );
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Capture(2)));
                          },
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(child: Image.asset('images/bottom_image_choose.png')))
          ],
        ),


      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _widget();
  }
}
