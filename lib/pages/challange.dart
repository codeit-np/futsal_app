import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futsal_app/api/api.dart';

class ChallangeScreen extends StatefulWidget {
  @override
  _ChallangeScreenState createState() => _ChallangeScreenState();
}

class _ChallangeScreenState extends State<ChallangeScreen> {
  Future getTeams() async {
    var response = await Api().getData('teams');
    var data = json.decode(response.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Challange"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: getTeams(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  default:
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var mydata = snapshot.data[index];
                        return Card(
                          elevation: .2,
                          child: ListTile(
                            leading: Icon(
                              Icons.sports_soccer,
                              size: 40,
                            ),
                            title: Text(mydata['team']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Manager: " + mydata['name'].toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "Phone: " + mydata['mobile'].toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                                Divider(),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (builder) {
                                          return AlertDialog(
                                            title: Text("Message"),
                                            content: Text(
                                                "Are you sure, you want to challange?"),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cancel")),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    Map data = {
                                                      "challange_to":
                                                          mydata['id']
                                                    };
                                                    var response = await Api()
                                                        .postData(
                                                            data, 'challange');
                                                    var result = json
                                                        .decode(response.body);
                                                    print(result);
                                                  },
                                                  child: Text("yes"))
                                            ],
                                          );
                                        });
                                  },
                                  child: Text("Challange"),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
