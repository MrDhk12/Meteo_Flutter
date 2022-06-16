import 'package:flutter/material.dart';
import 'package:meteo/Pages/Home_page.dart';
import 'package:meteo/db/data.dart';
import 'package:meteo/models/city_citydb.dart';
import 'package:meteo/services/db_service.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  TextEditingController cityController = TextEditingController();
  List<CityModel> datas = [];
  bool fetching = true;
  int currentIndex = 0;
  int _counter = 2;

  void _increment() {
    setState() {
      _counter++;
    }
  }

  late SqliteService db;
  @override
  void initState() {
    super.initState();
    db = SqliteService();
    getData2();
  }

  void getData2() async {
    datas = await db.getData();
    setState(() {
      fetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Cities"),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          onPressed: () {
            showMyDilogue();
          },
          child: Icon(Icons.add),
        ),
        body: fetching
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: DataCard(
                        data: datas[index],
                        edit: edit,
                        index: index,
                        delete: delete,
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return HomePage();
                        }));
                      });
                },
              ));
  }

  void showMyDilogue() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(14),
            content: Container(
              height: 70,
              child: Column(
                children: [
                  TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(labelText: "City"),
                      style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _increment();
                  CityModel dataLocal = CityModel(
                    id: _counter,
                    city: cityController.text,
                  );
                  db.inertData(dataLocal);
                  dataLocal.id = datas[datas.length - 1].id! + 1;
                  setState(() {
                    datas.add(dataLocal);
                  });
                  cityController.clear();
                  Navigator.pop(context);
                },
                child: Text("Save"),
              ),
            ],
          );
        });
  }

  void showMyDilogueUpdate() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(14),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(labelText: "title"),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  CityModel newData = datas[currentIndex];
                  newData.city = cityController.text;
                  db.update(newData, newData.id!);
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Text("Update"),
              ),
            ],
          );
        });
  }

  void edit(index) {
    currentIndex = index;
    cityController.text = datas[index].city;
    showMyDilogueUpdate();
  }

  void delete(int index) {
    db.delete(datas[index].id!);
    setState(() {
      datas.removeAt(index);
    });
  }

  void getCities(index) {
    db.getCities(datas[index].city);
  }
}
