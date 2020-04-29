import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import './SlidingScreen.dart';

var diets = [
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
final week = [
  "monday",
  "tuesday",
  "wednesday",
  "thursday",
  "friday",
  "saturday",
  "sunday"
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

class Api {
  Future<dynamic> sendreq(String diet, String tar) async {
    var param = {
      "apiKey": "154cc25b5a9d4aa39e8a1915b0840be1",
      "targetCalories": "2000",
      "timeFrame": "day"
    };
    if (diet != "None") param['diet'] = diet;
    param['targetCalories'] = tar;
    var url = "https://api.spoonacular.com/mealplanner/generate";
    Uri uri = Uri.parse(url);
    uri = uri.replace(queryParameters: param);
    var res = await http.get(uri);
    var dict = jsonDecode(res.body);
    var mp = new Map();
    List<Meals> li = new List<Meals>(3);
    for (int i = 0; i < 3; i++) {
      Meals m1 = new Meals();
      m1.id = dict["meals"][i]["id"];
      m1.readyInMinutes = dict["meals"][i]["readyInMinutes"];
      m1.sourceUrl = dict["meals"][i]["sourceUrl"];
      m1.title = dict["meals"][i]["title"];
      m1.servings = dict["meals"][i]["servings"];
      li[i] = m1;
    }

    li = await get_information(li);
    Diet d1 = new Diet();
    d1.calories = dict['nutrients']['calories'];
    d1.protein = dict['nutrients']['protein'];
    d1.fat = dict['nutrients']['fat'];
    d1.carbohydrates = dict['nutrients']['carbohydrates'];
    mp["Meals"] = li;
    mp["Diet"] = d1;
    return mp;
  }

  Future<dynamic> get_information(List<Meals> ids) async {
    String url =
        "https://api.spoonacular.com/recipes/informationBulk?apiKey=154cc25b5a9d4aa39e8a1915b0840be1&ids=";
    for (int i = 0; i < ids.length; i++) {
      url += '${ids[i].id},';
    }
    url = url.substring(0, url.length - 1);
    var res = await http.get(url);
    var lis = jsonDecode(res.body);
    for (int i = 0; i < ids.length; i++) {
      ids[i].extra_information['image'] = lis[i]['image'];
      ids[i].extra_information['healthScore'] = lis[i]['healthScore'];
      ids[i].extra_information['pricePerServing'] = lis[i]['pricePerServing'];
      ids[i].extra_information['spoonacularScore'] = lis[i]['spoonacularScore'];
    }
    return ids;
  }

  Future<dynamic> random_meals() async {
    var param = {"apiKey": "154cc25b5a9d4aa39e8a1915b0840be1", "number": "100"};
    var url = "https://api.spoonacular.com/mealplanner/generate";
    Uri uri = Uri.parse(url);
    uri = uri.replace(queryParameters: param);
    var res = await http.get(uri);
    var di = jsonDecode(res.body);
    var dic = di["week"];
    var mp = new Map();
    List<Meals> fin = new List<Meals>();
    for (int j = 0; j < 7; j++) {
      var dict = dic[week[j]];
      List<Meals> li = new List<Meals>(3);
      for (int i = 0; i < 3; i++) {
        Meals m1 = new Meals();
        m1.id = dict["meals"][i]["id"];
        m1.readyInMinutes = dict["meals"][i]["readyInMinutes"];
        m1.sourceUrl = dict["meals"][i]["sourceUrl"];
        m1.title = dict["meals"][i]["title"];
        m1.servings = dict["meals"][i]["servings"];
        li[i] = m1;
      }
      fin.addAll(li);
    }
    fin = await get_information(fin);
    var nut = new List();
    for (int j = 0; j < 7; j++) {
      var dict = dic[week[j]];
      Diet d1 = new Diet();
      d1.calories = dict['nutrients']['calories'];
      d1.protein = dict['nutrients']['protein'];
      d1.fat = dict['nutrients']['fat'];
      d1.carbohydrates = dict['nutrients']['carbohydrates'];
      nut.add(d1);
    }
    print("${fin.length} Length");
    mp["meals"] = fin;
    mp["nutrients"] = nut;
    print(fin);
    print(nut);
    return mp;
  }
}
