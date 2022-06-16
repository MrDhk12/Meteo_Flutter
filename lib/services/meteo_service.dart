import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:meteo/models/city4H.dart';
import 'package:meteo/models/city_citydb.dart';

Future<City> getMainpageInfo(String city) async {
  City currentCity = new City();
  // String city = "Lyon";
  String apikey = "66f891830f221301ee4bbefe7b115ff6";
  //https://api.openweathermap.org/data/2.5/weather?q=lyon&appid=0ab41fe6a9d03611b9c79fe2fde7e059&lang=fr&unit=metric
  var url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apikey&lang=fr&units=metric");
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = City.fromJson(jsonDecode(response.body));
    return jsonResponse;
  } else {
    print('Error: ${response.statusCode}.');
  }

  return currentCity;
}

Future<City4H> get4HInfo(String city) async {
  City4H city4H = new City4H();
  // String city = "Lyon";
  String apikey = "66f891830f221301ee4bbefe7b115ff6";
  //https://samples.openweathermap.org/data/2.5/forecast?id=524901&appid=b1b15e88fa797225412429c1c50c122a1
  var url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apikey&lang=fr&units=metric");
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = City4H.fromJson(jsonDecode(response.body));
    return jsonResponse;
  } else {
    print('Error: ${response.statusCode}.');
  }

  return city4H;
}
// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:meteo/models/meteo_model.dart';

// Future<Meteo> getCityWeather(String name) async {
//   Meteo meteo = Meteo();
//   // https://api.openweathermap.org/data/2.5/weather?q=lyon&appid=1acbb618f0635b5dabebff1e2531142c
//   var url = Uri.https('api.openweathermap.org', "/data/2.5/weather",
//       {"q": name, "appid": "66f891830f221301ee4bbefe7b115ff6"});
//   var response = await http.get(url);
//   if (response.statusCode == 200) {
//     var jsonResponse = jsonDecode(response.body);
//     List<Weather> listWeather = convertToWeather(jsonResponse["weather"]);
//     Main main = convertToMain(jsonResponse["main"]);
//     meteo = Meteo(
//         jsonResponse["id"], jsonResponse["name"], listWeather, main, null);
//   } else {
//     print("Request failed with status: ${response.statusCode}");
//   }

//   return meteo;
// }

// Main convertToMain(dynamic dynamic) {
//   return Main(
//       dynamic["temp"].toDouble(),
//       dynamic["pressure"],
//       dynamic["humidity"],
//       dynamic["temp_min"].toDouble(),
//       dynamic["temp_max"].toDouble());
// }

// List<Weather> convertToWeather(jsonResponse) {}

// Future<List<Meteo>> getCity5DaysWeather(String name) async {
//   List<Meteo> list5DaysWeather = [];
//   var url = Uri.https("authority");
//   var response = await http.get(url);
//   if (response.statusCode == 200) {
//     var jsonResponse = jsonDecode(response.body);
//     for (var data in jsonResponse["list"]) {
//       List<Weather> listWeather = convertToWeather(data["weather"]);
//       Main main = convertToMain(data["main"]);
//       DateTime date = convertToDateTime(data["dt_txt"]);
//       Meteo meteo = Meteo(null, null, listWeather, main, date);
//       list5DaysWeather.add(meteo);
//     }
//   } else {
//     print("Request failed with status: ${response.statusCode}");
//   }
//   return meteo;
// }

// DateTime convertToDateTime(data) {
//   return DateTime.parse(data);
// }

// Future<Meteo> getMeteoData(String city) async {
//   Meteo meteo = Meteo([], Main(0, 0, 0, 0, 0, 0), Wind(0, 0, 0), Clouds(0), 0,
//       Sys(0, 0, "", 0, 0), 0, 0, "", 444);
//   //https://jsonplaceholder.typicode.com/genre
//   //https://api.openweathermap.org/data/2.5/weather?q=lyon&appid=a9cfd822e4f8f61c11082ab1d62a6fda

//   var url = Uri.https('api.openweathermap.org', "/data/2.5/weather",
//       {"q": city, "appid": "cc1fb0360be232be857c78980b1a88f8"});
//   var response = await http.get(url);
//   if (response.statusCode == 200) {
//     var jsonResponse = jsonDecode(response.body);
//     // List<Weather> listWeather = ConvertWeather(jsonResponse["weather"]);
//     List weather = jsonResponse["weather"];
//     Main mainConvert = Main.fromJson(jsonResponse["main"]);
//     Wind windConvert = Wind.fromJson(jsonResponse["wind"]);
//     Clouds cloudsConvert = Clouds.fromJson(jsonResponse["clouds"]);
//     Sys sysConvert = Sys.fromJson(jsonResponse["sys"]);

//     meteo = Meteo(
//         customWeatherCast(weather),
//         mainConvert,
//         windConvert,
//         cloudsConvert,
//         jsonResponse["dt"],
//         sysConvert,
//         jsonResponse["id"],
//         jsonResponse["timezone"],
//         jsonResponse["name"],
//         jsonResponse["cod"]);
//   } else {
//     if (kDebugMode) {
//       print("Request failed with status: ${response.statusCode}");
//     }
//   }
//   return meteo;
// }

// List<Weather> customWeatherCast(List<dynamic> weather) {
//   List<Weather> weatherList = [];
//   for (dynamic object in weather) {
//     Weather weather = Weather(
//         object["id"], object["main"], object["description"], object["icon"]);
//     weatherList.add(weather);
//   }
//   return weatherList;
// }