import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futsal_app/api/api.dart';
import 'package:futsal_app/component/textfield.dart';
import 'package:futsal_app/const/const.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                inputText('Manager Name', Icons.person, 'text', false, name),
                inputText('Email', Icons.email, 'email', false, email),
                inputText('Team Name', Icons.group, 'text', false, teamname),
                inputText('Phone', Icons.call, 'phone', false, phone),
                inputText('Password', Icons.lock, 'password', true, password),
                ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState.validate()) {
                        Map data = {
                          "name": name.text,
                          "email": email.text,
                          "team": teamname.text,
                          "mobile": phone.text,
                          "password": password.text,
                          "is_admin": 0
                        };

                        var response =
                            await Api().loginAndRegister(data, 'register');
                        var result = json.decode(response.body);
                        print(result);
                        if (result['message'] == "user created") {
                          showDialog(
                              context: context,
                              builder: (builder) {
                                return AlertDialog(
                                  title: Text("Message"),
                                  content: Text("Team registered successfully"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, 'login');
                                        },
                                        child: Text("OK"))
                                  ],
                                );
                              });
                        }
                      }
                    },
                    child: Text("REGISTER"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
