import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futsal_app/api/api.dart';
import 'package:futsal_app/component/drawer.dart';
import 'package:futsal_app/const/const.dart';
import 'package:futsal_app/pages/events.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future getData() async {
    var response = await Api().getData('events');
    var data = json.decode(response.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(
        title: Text("Big Foot"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Slide
            //Upcoming Events
            ListTile(
              title: Text("Upcoming Events"),
              subtitle: Text("Are you ready for next events"),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var mydata = snapshot.data[index];
                          return Card(
                            elevation: .2,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EventScreen(
                                              id: mydata['id'],
                                            )));
                              },
                              child: Container(
                                width: 150,
                                height: 200,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  link + mydata['image']),
                                              fit: BoxFit.cover)),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 150,
                                      height: 40,
                                      child: Text(
                                        mydata['title'],
                                        style: TextStyle(fontSize: 12),
                                        maxLines: 1,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
