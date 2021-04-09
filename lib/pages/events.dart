import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futsal_app/api/api.dart';
import 'package:futsal_app/const/const.dart';

class EventScreen extends StatefulWidget {
  final int id;
  EventScreen({this.id});
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  Future getData(String id) async {
    var response = await Api().getData('events/$id');
    var data = json.decode(response.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Event"),
        ),
        body: FutureBuilder(
          future: getData(widget.id.toString()),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      //Image
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    NetworkImage(link + snapshot.data['image']),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title: Text(snapshot.data['title']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.event),
                                Text("Tiesheet Date: " +
                                    snapshot.data['tiesheet_date']),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.event),
                                Text("Last Entry Date: " +
                                    snapshot.data['lastentry_date']),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.place),
                                Text("Venue: " + snapshot.data['venue']),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.person),
                                Text(
                                    "Organiser: " + snapshot.data['organiser']),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.call),
                                Text("Contact: " + snapshot.data['contact']),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      ListTile(
                        title: Text("Description"),
                        subtitle: Text(
                          snapshot.data['description'].toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                );
            }
          },
        ));
  }
}
