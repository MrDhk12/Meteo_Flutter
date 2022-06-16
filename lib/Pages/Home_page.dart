import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:jiffy/jiffy.dart';
import 'package:meteo/Pages/Home_second_screen.dart';

import 'package:meteo/views/home_detail.dart';
import 'package:meteo/models/city4H.dart';
import 'package:meteo/models/city_citydb.dart';
import 'package:meteo/services/meteo_service.dart';
import 'package:meteo/views/meteo_detail.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          MeteoActu(),
          MeteoJour(),
        ],
      ),
    );
  }
}

class MeteoActu extends StatelessWidget {
  const MeteoActu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CityModel> datas = [];
    DateTime currentTime = DateTime.now();
    return GlowContainer(
      height: MediaQuery.of(context).size.height - 230,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.only(top: 5, left: 30, right: 30),
      glowColor: Color.fromARGB(255, 22, 146, 203).withOpacity(0.5),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(50),
        bottomRight: Radius.circular(50),
      ),
      color: Color.fromARGB(255, 22, 146, 203),
      spreadRadius: 5,
      child: FutureBuilder<City>(
          future: getMainpageInfo("Lyon"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Chargement en cours..."));
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return HomePage2();
                          }));
                        },
                        child: Icon(
                          Icons.reorder_rounded,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            snapshot.data!.name.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.2, color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "Actualiser",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 330,
                    child: Stack(
                      children: [
                        Image(
                          image: AssetImage("assets/clear.png"),
                          fit: BoxFit.fill,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Center(
                            child: Column(
                              children: [
                                GlowText(
                                  (snapshot.data!.main!.temp!)
                                          .toInt()
                                          .toString() +
                                      "\u00B0",
                                  style: TextStyle(
                                      height: 0.1,
                                      fontSize: 70,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  (snapshot.data!.weather![0].description)
                                      .toString(),
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  Jiffy(currentTime)
                                      .format('EEEE dd MMMM yyyy')
                                      .toString(),
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(color: Colors.white),
                  SizedBox(
                    height: 5,
                  ),
                  MeteoDetail(),
                ],
              );
            } else {
              return const Text("Une error est survenue. ");
            }
          }),
    );
  }
}

class MeteoJour extends StatelessWidget {
  const MeteoJour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Aujourd'hui",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return PageDetail();
                  }));
                },
                child: Row(
                  children: [
                    Text(
                      "5 jours",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                      size: 15,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 30,
            ),
            child: FutureBuilder<City4H>(
                future: get4HInfo("Lyon"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: Text("Chargement en cours..."));
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MeteoWidget(snapshot.data!.list![0]),
                          MeteoWidget(snapshot.data!.list![1]),
                          MeteoWidget(snapshot.data!.list![2]),
                          MeteoWidget(snapshot.data!.list![3]),
                        ]);
                  } else {
                    return const Text("Une error est survenue.");
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class MeteoWidget extends StatelessWidget {
  final ListW meteo;
  MeteoWidget(this.meteo);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.white),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          Text((meteo.main!.temp!.toInt()).toString() + "\u00B0",
              style: TextStyle(fontSize: 20)),
          SizedBox(
            height: 2,
          ),
          Image(
            image: AssetImage("assets/rainy_2d.png"),
            width: 40,
            height: 40,
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            Jiffy(meteo.dtTxt).format('H:mm').toString(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff030317),
//       body: Column(children: [TodayWeather()]),
//     );
//   }
// }

// class TodayWeather extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 30, right: 30, top: 10),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Today',
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//               ),
//               Row(
//                 children: [
//                   Text(
//                     "7 Days",
//                     style: TextStyle(fontSize: 18, color: Colors.grey),
//                   ),
//                   Icon(
//                     Icons.arrow_forward_ios_outlined,
//                     color: Colors.grey,
//                     size: 15,
//                   )
//                 ],
//               )
//             ],
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Container(
//             margin: EdgeInsets.only(bottom: 30),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               // children: [WeatherWidget(TodayWeather[0])]
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class WeatherWidget extends StatelessWidget {
//   final Weather weather;
//   WeatherWidget(this.weather);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(15),
//       decoration: BoxDecoration(
//           border: Border.all(width: 0.2, color: Colors.white),
//           borderRadius: BorderRadius.circular(35)),
//       child: Column(
//         children: [
//           Text(
//             weather.current.toString() + "\u00B0",
//             style: TextStyle(fontSize: 20),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Image(
//             image: AssetImage(weather.image),
//             width: 50,
//             height: 50,
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text(
//             weather.time,
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           )
//         ],
//       ),
//     );
//   }
// }
