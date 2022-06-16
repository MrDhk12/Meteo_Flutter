import 'package:flutter/material.dart';
import 'package:meteo/models/city4H.dart';
import 'package:meteo/models/city_citydb.dart';
import 'package:meteo/services/meteo_service.dart';

class MeteoDetail extends StatelessWidget {
  const MeteoDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CityModel> datas = [];
    int currentIndex = 0;
    // CityModel city = datas[currentIndex];
    return Container(
        child: FutureBuilder<City>(
            future: getMainpageInfo("Lyon"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("Chargement en cours..."));
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.air,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          (snapshot.data!.wind! * 3.6).toInt().toString() +
                              " km/h",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Vent",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ImageIcon(
                          AssetImage('assets/humidity.png'),
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          snapshot.data!.main!.humidity.toString() + " %",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Humidité",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const Text("Une error est survenue.");
              }
            }));
  }
}

class MeteoDetail4H extends StatelessWidget {
  const MeteoDetail4H({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CityModel> datas = [];
    int currentIndex = 0;
    // CityModel city = datas[currentIndex];
    return Container(
        child: FutureBuilder<City4H>(
            future: get4HInfo("Lyon"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("Chargement en cours..."));
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.air,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          (snapshot.data!.list![10].wind!.speed! * 3.6)
                                  .toInt()
                                  .toString() +
                              " km/h",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Vent",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ImageIcon(
                          AssetImage('assets/humidity.png'),
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          snapshot.data!.list![10].main!.humidity.toString() +
                              " %",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Humidité",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const Text("Une error est survenue.");
              }
            }));
  }
}
