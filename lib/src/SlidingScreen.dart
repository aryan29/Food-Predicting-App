import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import './MealsShow.dart';

class Sliding extends StatefulWidget {
  var mp;
  Sliding({Key key, @required this.mp}) : super(key: key);

  @override
  _SlidingState createState() => _SlidingState();
}

class _SlidingState extends State<Sliding> {
  final week = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  buildWidget(int index) {
    return Container(
         width: double.infinity,
        child: Column(
      children: <Widget>[
        Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            height: 80,
            color: Colors.black,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                week[index],
                textAlign: TextAlign.center,
                style: GoogleFonts.abel(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            )
            ),

        Expanded(
            child: ListView(
            scrollDirection: Axis.vertical,
           shrinkWrap: true,
            children:<Widget>[
            MealShowState().DietCard(widget.mp["nutrients"][index]),
            MealShowState().mealCard(widget.mp["meals"][index*3+0]),
            MealShowState().mealCard(widget.mp["meals"][index*3+1]),
            MealShowState().mealCard(widget.mp["meals"][index*3+2]),

            ]
          ),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: CarouselSlider(
        items: [0, 1, 2, 3, 4, 5, 6].map<Widget>((i) {
          return buildWidget(i);
        }).toList(),
        options: CarouselOptions(
          enableInfiniteScroll:true,
          height: double.infinity,
          autoPlay: false,
          enlargeCenterPage: false,
          initialPage: 1,
        ),
      ),
    ));
  }
}
