import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futsal_app/api/api.dart';
import 'package:futsal_app/provider/provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future getTeams() async {
    var response = await Api().getData('teams');
    var data = json.decode(response.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    PlayerProvider provider = Provider.of<PlayerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
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
                                    provider.setID(mydata['id']);
                                    Navigator.pushNamed(context, 'teamprofile');
                                  },
                                  child: Text("Team Profile"),
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
