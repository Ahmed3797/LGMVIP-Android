import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'District.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Covid 19 Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<District>> getData() async {
    List<District> lst = [];
    String url = 'https://data.covid19india.org/state_district_wise.json';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var item in data.values) {
        item["districtData"].forEach((keys, values) {
          var a = District.fromjson(values, keys);
          lst.add(a);
        });
      }
      return lst;
    }
    return <District>[];
  }

  @override
  Widget build(BuildContext context) {
    var md = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<District>>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<District> dist = snapshot.data!;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: dist.length,
                  itemBuilder: ((context, index) {
                    District city = dist[index + 1];
                    return Container(
                      margin: EdgeInsets.all(2),
                      child: Card(
                        color: Colors.amber.withOpacity(1),
                        elevation: 3,
                        shadowColor: Colors.orange,
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.32,
                                          height: 270,
                                          imageUrl:
                                              'https://images.unsplash.com/photo-1597058712635-3182d1eacc1e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8aW5kaWFuJTIwZmxhZ3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
                                    ),
                                    Positioned(
                                      bottom: 25,
                                      left: 3,
                                      child: Text(
                                        "${city.stateName}",
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                    )
                                  ]),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "Patients",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.lightGreen),
                                          )
                                        ],
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Customdesign(
                                              head: "Active",
                                              icons: Icon(
                                                Icons.local_hospital,
                                                color: Colors.red,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                              ),
                                              number: city.active,
                                            ),
                                            Customdesign(
                                              head: "Confirmed",
                                              icons: Icon(
                                                Icons.personal_injury,
                                                color: Colors.orange,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                              ),
                                              number: city.confirmed,
                                            ),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Customdesign(
                                              head: "Migrated",
                                              icons: Icon(
                                                Icons.car_crash,
                                                color: Colors.pink,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                              ),
                                              number: city.active,
                                            ),
                                            Customdesign(
                                              head: "Deceased",
                                              icons: Icon(
                                                Icons
                                                    .face_retouching_off_outlined,
                                                color: Colors.black12,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                              ),
                                              number: city.confirmed,
                                            ),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Customdesign(
                                              head: "Recovered",
                                              icons: Icon(
                                                Icons.favorite,
                                                color: Colors.green,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                              ),
                                              number: city.active,
                                            ),
                                          ]),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "Delta Patients",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.lightGreen),
                                          ),
                                        ],
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Customdesign(
                                              head: "Confirmed",
                                              icons: Icon(
                                                Icons.personal_injury,
                                                color: Colors.orange,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                              ),
                                              number: city.Deltaconfirmed,
                                            ),
                                            Customdesign(
                                              head: "Deceased",
                                              icons: Icon(
                                                Icons
                                                    .face_retouching_off_outlined,
                                                color: Colors.black,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                              number: city.Deltadeceased,
                                            ),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Customdesign(
                                              head: "Recovered",
                                              icons: Icon(
                                                Icons.favorite,
                                                color: Colors.green,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                              ),
                                              number: city.Deltarecovered,
                                            ),
                                          ])
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }));
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class Customdesign extends StatefulWidget {
  Icon icons;
  late String head;
  int? number;
  Customdesign(
      {Key? key, required this.icons, required this.head, required this.number})
      : super(key: key);

  @override
  State<Customdesign> createState() => _Customdesign();
}

class _Customdesign extends State<Customdesign> {
  double getfontsize() {
    var font;
    MediaQuery.of(context).size.width <= 450 ? font = 14.0 : font = 16.0;

    return font;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.icons,
        Text(
          "${widget.head} ",
          style: TextStyle(fontSize: getfontsize(), color: Colors.black),
        ),
        Text(
          "${widget.number}",
          style: TextStyle(fontSize: getfontsize(), color: Colors.green),
        ),
      ],
    );
  }
}
