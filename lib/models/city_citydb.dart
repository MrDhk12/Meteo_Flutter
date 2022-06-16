class City {
  List<Weather>? weather;
  Main? main;
  double? wind;
  String? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  City(
      {this.weather,
      this.main,
      this.wind,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod});

  City.fromJson(Map<String, dynamic> json) {
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(new Weather.fromJson(v));
      });
    }
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    wind = json['wind']['speed'];
    sys = json['sys']['country'];
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.weather != null) {
      data['weather'] = this.weather!.map((v) => v.toJson()).toList();
    }
    if (this.main != null) {
      data['main'] = this.main!.toJson();
    }
    data['timezone'] = this.timezone;
    data['id'] = this.id;
    data['name'] = this.name;
    data['cod'] = this.cod;
    return data;
  }
}

class Weather {
  String? main;
  String? description;

  Weather({this.main, this.description});

  Weather.fromJson(Map<String, dynamic> json) {
    main = json['main'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['main'] = this.main;
    data['description'] = this.description;
    return data;
  }
}

class Main {
  double? temp;
  int? humidity;

  Main({this.temp, this.humidity});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['humidity'] = this.humidity;
    return data;
  }
}

class CityModel {
  int? id;
  String city;

  CityModel({this.id, required this.city});

  factory CityModel.fromMap(Map<String, dynamic> json) =>
      CityModel(id: json["id"], city: json["city"]);

  Map<String, dynamic> toMap() {
    return {'id': id, 'city': city};
  }
}
