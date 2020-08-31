import 'package:flutter/material.dart';

class Calibrate_Preview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Calibrate_Preview_State();
  }
}

class Calibrate_Preview_State extends State<Calibrate_Preview> {
  Widget _widget() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color red = Color(0xff9d0301);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {},
          child: Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: red,
        title: Text('Calibrate Preview'),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Image.asset("images/ic_undo_white_24dp.png"),
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset("images/ic_done_white_24dp.png"),
              ),
            ],
          )
        ],
      ),
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background_flat.jpg"),
              fit: BoxFit.cover),
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 32.0,left:16.0,right: 16.0),
              child: Text(
                "Attach the MySelf device on the phone and use the volume buttons to resize the camera preview",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 24,),textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 64.0,right: 16,left: 180),
              child: Container(
                height: 250,
                color: Colors.yellow,

              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final md = MediaQuery.of(context);
    if (md.orientation == Orientation.landscape) {
      return _widget();
    }
    return _widget();
  }
}
