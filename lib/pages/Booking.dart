import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futsal_app/api/api.dart';
import 'package:futsal_app/const/const.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  TextEditingController screeningDate = TextEditingController();
  TextEditingController time = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  Future _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2090));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        screeningDate.text = selectedDate.toString().substring(0, 10);
      });
    }
  }

  List<String> times = [
    '6:00',
    '7:00',
    '8:00',
    '9:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: screeningDate,
                  decoration: InputDecoration(
                      hintText: 'Select Date',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.event),
                        onPressed: () {
                          _selectDate();
                        },
                      )),
                ),
                TextFormField(
                  controller: time,
                  decoration:
                      InputDecoration(hintText: 'eg. between 6:00 to 20:00'),
                  validator: (value) => value.isEmpty ? 'required' : null,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState.validate()) {
                        Map data = {
                          'date': screeningDate.text,
                          'time': time.text
                        };

                        var response = await Api().postData(data, 'booking');
                        var result = json.decode(response.body);
                        print(result);
                        if (result['message'] == 'success') {
                          showDialog(
                              context: context,
                              builder: (builder) {
                                return AlertDialog(
                                  title: Text("Message"),
                                  content: Text(
                                      "Message sent, We will contact you soon"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("OK"))
                                  ],
                                );
                              });
                        }
                      }
                    },
                    child: Text("Book Now"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
