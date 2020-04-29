import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './meal_panner.dart';
import './SlidingScreen.dart';

class RandomRecipies extends StatefulWidget {
  @override
  _RandomRecipiesState createState() => _RandomRecipiesState();
}

class _RandomRecipiesState extends State<RandomRecipies> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.3), BlendMode.lighten),
                  image: NetworkImage(
                      "https://www.foodiesfeed.com/wp-content/uploads/2019/06/top-view-for-box-of-2-burgers-home-made.jpg"))),
          child: Container(
              child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 70.0, left: 20.0),
              alignment: Alignment.centerLeft,
              child: Text("FLORA",
                  style: GoogleFonts.girassol(
                      fontSize: 50, letterSpacing: 4.0, color: Colors.black)),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 100.0),
              alignment: Alignment.topLeft,
              child: Text("An app Where you can found all food over internet",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.bitter(
                      fontSize: 14, letterSpacing: 2.0, color: Colors.black)),
            ),
            SizedBox(height: 450),
            RaisedButton(
                focusColor: Colors.white,
                hoverColor: Colors.white,
                splashColor: Colors.white,
                highlightColor: Colors.white,
                elevation: 20.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.white)),
                child: Ink(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.black,
                              Colors.grey[350],
                              Colors.white
                            ])),
                    child: Container(
                        width: 200,
                        constraints: const BoxConstraints(
                            minWidth: 88.0, minHeight: 36.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Generate',
                          textAlign: TextAlign.center,
                        ))),
                padding: EdgeInsets.all(5.0),
                color: Colors.black,
                onPressed: () async{
                  var z = await Api().random_meals();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Sliding(mp:z)));
                })
          ]))),
    );
  }
}
