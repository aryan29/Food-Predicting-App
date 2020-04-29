import 'package:fitness/src/MealsShow.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import './meal_panner.dart';
import './MealsShow.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MealScreen extends StatefulWidget {
  MealScreen({Key key}) : super(key: key);

  @override
  _MealScreenState createState() => _MealScreenState();
}

bool isLoading = false;
var _diets = [
  "None",
  "Gluten Free",
  "Ketogenic",
  "Vegetarian",
  "Lacto-Vegetarian",
  "Ovo-Vegetarian",
  "Vegan",
  "Pescetarian",
  "Paleo",
  "Primal",
  "Whole30"
];

class Meals {
  int id;
  int servings;
  int readyInMinutes;
  String sourceUrl;
  String title;
  var extra_information = new Map();
}

class Diet {
  double calories;
  double protein;
  double fat;
  double carbohydrates;
}

double _targetCalories = 2250;
String _diet = 'None';

class _MealScreenState extends State<MealScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  "https://images.pexels.com/photos/255501/pexels-photo-255501.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"))),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
              width: 300.0,
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 120),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10.0),
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    'My Daily Meal Planner',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  ),
                  SizedBox(height: 20.0),
                  RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .body1
                            .copyWith(fontSize: 25),
                        children: [
                          TextSpan(
                              text: _targetCalories.truncate().toString(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: 'cal',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ]),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: Theme.of(context).primaryColor,
                      inactiveTrackColor: Colors.lightBlue[100],
                      trackHeight: 6,
                    ),
                    child: Slider(
                      min: 300,
                      max: 4500,
                      value: _targetCalories,
                      onChanged: (value) => setState(() {
                        _targetCalories = value.round().toDouble();
                      }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: DropdownButtonFormField(
                      items: _diets.map((String priority) {
                        return DropdownMenuItem(
                          value: priority,
                          child: Text(
                            priority,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Diet',
                        labelStyle: TextStyle(fontSize: 18),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _diet = value;
                        });
                      },
                      value: _diet,
                    ),
                  ),
                  //Space
                  SizedBox(height: 70),
                  FlatButton.icon(
                      color: Colors.grey[400],
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      hoverColor: Colors.grey[100],
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        var req = await Api()
                            .sendreq(_diet, _targetCalories.toString());
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MealShow(li: req)));
                      },
                      icon: Icon(FontAwesomeIcons.pizzaSlice),
                      label: (!isLoading)
                          ? Text("Generate")
                          : SpinKitFadingCircle(
                              color: Colors.white,
                              size: 50.0,
                            ))
                ],
              ))),
    );
  }
}
