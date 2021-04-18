import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futsal_app/api/api.dart';

class OfferScreen extends StatefulWidget {
  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  Future getDetails() async {
    var response = await Api().getData('offers');
    var data = json.decode(response.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offer"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Games",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Time",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Price",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                FutureBuilder(
                  future: getDetails(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var mydata = snapshot.data[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  mydata['game'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  mydata['time'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  mydata['price'].toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            );
                          },
                        );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
