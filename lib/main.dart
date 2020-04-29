import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'src/MealScreen.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'src/RandomMeal.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Color(0XFF6D3FFF),
          accentColor: Color(0XFF6D3FFF),
        ),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Pedometer _pedometer;
  StreamSubscription<int> _subscription;
  String _stepCountValue = 'unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    startListening();
  }

  void onData(int stepCountValue) {
    print(stepCountValue);
  }

  void startListening() {
    _pedometer = new Pedometer();
    _subscription = _pedometer.pedometerStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: false);
  }

  void stopListening() {
    _subscription.cancel();
  }

  void _onData(int stepCountValue) async {
    setState(() => _stepCountValue = "$stepCountValue");
  }

  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String get_dis() {
    double st = double.parse(_stepCountValue);
    st = (st * 0.6) / 1000;
    String s = st.toString();
    return s.substring(0, min(5, s.length));
  }

  String get_cal() {
    double st = double.parse(_stepCountValue);
    st = (st * 0.6 * 45) / 1000;
    String s = st.toString();
    return s.substring(0, min(5, s.length));
  }

  double get_percent() {
    int val = int.parse(_stepCountValue);
    val = min(1000, val);
    print(val);
    print((val / 1000.0));
    return (val / 1000.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: new Drawer(
            child: new DrawerHeader(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.dstATop),
                    image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTuRX7ez7wwb69rE9fA15h8rYVyRZccXjRIOYebjwFowouOGNIx&usqp=CAU"),
                  )),
                ),
              ),
              ListTile(
                title: Text(
                  "Meal Plan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.purple, fontFamily: "bold", fontSize: 16.0),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MealScreen()),
                  );
                },
              ),
              ListTile(
                title: Text("Random Meal",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.purple,
                        fontFamily: "bold",
                        fontSize: 16.0)),
                                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RandomRecipies()),
                  );
                },
              ),
              ListTile(
                title: Text("Lets Exercise",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.purple,
                        fontFamily: "bold",
                        fontSize: 16.0)),
                onTap: () {},
              ),
            ],
          ),
          decoration: new BoxDecoration(color: Color(0xff21254A)),
        )),
        backgroundColor: Color(0xff21254A),
        body: Container(
          child: Column(
            children: <Widget>[
              ColumnSuper(innerDistance: -200.0, children: [
                Container(
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://raw.githubusercontent.com/oliver-gomes/flutter-loginui/master/assets/images/1.png")))),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    padding: EdgeInsets.all(20.0),
                    iconSize: 30.0,
                    icon: Icon(Icons.menu),
                    color: Colors.white,
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                ),
              ]),
              SizedBox(
                height: 200,
              ),
              // new Text('Step count: $_stepCountValue'),
              new CircularPercentIndicator(
                radius: 200.0,
                animation: true,
                lineWidth: 10.0,
                animationDuration: 10000,
                percent: get_percent(),
                // header: new Text("Icon header"),
                center: Icon(FontAwesomeIcons.walking,
                    size: 50.0, color: Colors.white),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.grey[50],
                progressColor: Colors.blue,
              ),
              SizedBox(height: 50),
              Text('$_stepCountValue STEPS',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 50),
              Container(
                  child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('DISTANCE',
                              style: TextStyle(
                                color: Colors.pink[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: get_dis(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' km',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ))
                            ]),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('CALORIES',
                              style: TextStyle(
                                color: Colors.pink[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: get_cal(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
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
                        ],
                      )),
                ],
              ))
            ],
          ),
        ));
  }
}
