import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import './MealsShow.dart';

class Meals {
  int id;
  int servings;
  int readyInMinutes;
  String sourceUrl;
  String title;
  var extra_information = new Map();
}

class MealShow extends StatefulWidget {
  var li;
  MealShow({Key key, @required this.li}) : super(key: key);

  @override
  MealShowState createState() => MealShowState();
}

class MealShowState extends State<MealShow> {
  DietCard(var diet) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          color: Color.fromRGBO(234, 250, 241, 1),
          alignment: Alignment.center,
          height: 180,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(children: <Widget>[
                        Text("CALORIES",
                            style: GoogleFonts.merriweather(
                                color: Colors.blue, fontSize: 18)),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: diet.calories.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(
                                text: ' cal',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ))
                          ]),
                        )
                      ]),
                      Column(children: <Widget>[
                        Text("PROTIEN",
                            style: GoogleFonts.merriweather(
                                color: Colors.blue, fontSize: 18)),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: diet.protein.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(
                                text: ' gm',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ))
                          ]),
                        )
                      ])
                    ]),
              ),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(children: <Widget>[
                        Text("FAT",
                            style: GoogleFonts.merriweather(
                                color: Colors.blue, fontSize: 18)),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: diet.fat.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(
                                text: ' gm',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ))
                          ]),
                        )
                      ]),
                      Column(children: <Widget>[
                        Text("CARBOHYDRATES",
                            style: GoogleFonts.merriweather(
                                color: Colors.blue, fontSize: 18)),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: diet.carbohydrates.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(
                                text: ' cal',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ))
                          ]),
                        )
                      ])
                    ]),
              )
            ],
          )),
    );
  }
Widget generate_information(final String s1,final String s2)
{
                          return RichText(
                            textAlign: TextAlign.left,
                          text: TextSpan(children: [
                            TextSpan(
                                text: s1,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(
                                text: " "+s2,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ))
                          ]),
                        );
}
  mealCard(var meal) {
    return InkWell(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape:RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(40)
                ),
                elevation:20,
                child:Container(
                  height:400,
                  width:300,
                  child:Column(
                    children:<Widget>[
                      Container(
                        height: 200,
                        decoration:BoxDecoration(
                          image:DecorationImage(
                            fit: BoxFit.cover,
                            image:NetworkImage(meal.extra_information['image'])
                            )
                        )
                      ),
                      Divider(color:Colors.black),
                      generate_information("Title",meal.title),
                      generate_information("Id",meal.id.toString()),
                      generate_information("ReadyInMinutes",meal.readyInMinutes.toString()),
                      generate_information("Servings",meal.servings.toString()),
                      generate_information("PricePerServing(Rs)",meal.extra_information['pricePerServing'].toString()),
                      generate_information("HealthScore",meal.extra_information['healthScore'].toString()),
                      generate_information("SpoonacularScore",meal.extra_information['spoonacularScore'].toString()),


                    ]
                  )

                )

              );
            });
      },
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Webview(link: meal.sourceUrl)));
        //Open Webview
      },
      child: Container(
          child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 220,
            width:double.infinity,
            //width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.5), BlendMode.dstATop),
                  image: NetworkImage(meal.extra_information['image'])),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Container(
              padding: EdgeInsets.all(50),
              child: Column(
                children: <Widget>[
                  Text(meal.title,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.abrilFatface(
                        letterSpacing: 5,
                        fontSize: 15,
                        color: Colors.black,
                      ))
                ],
              ))
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return DietCard(widget.li['Diet']);
                } else {
                  return mealCard(widget.li['Meals'][index - 1]);
                }
              })
              ),
    );
  }
}

class Webview extends StatelessWidget {
  const Webview({Key key, @required this.link}) : super(key: key);
  final String link;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        initialUrl: link,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
