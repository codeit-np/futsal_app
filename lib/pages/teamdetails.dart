import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futsal_app/api/api.dart';
import 'package:futsal_app/const/const.dart';
import 'package:futsal_app/provider/provider.dart';
import 'package:provider/provider.dart';

class TeamProfile extends StatefulWidget {
  @override
  _TeamProfileState createState() => _TeamProfileState();
}

class _TeamProfileState extends State<TeamProfile> {
  Future getData(int id) async {
    var response = await Api().getData('teams/$id');
    var data = json.decode(response.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    PlayerProvider provider = Provider.of<PlayerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: getData(provider.userID),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  default:
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          var mydata = snapshot.data[index];
                          return Card(
                            elevation: .2,
                            child: Column(
                              children: [
                                Expanded(
                                    child:
                                        Image.network(link + mydata['image'])),
                                Text(
                                  mydata['name'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Divider(),
                                Text(
                                  mydata['position'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          );
                        });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
