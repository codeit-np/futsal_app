import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:futsal_app/api/api.dart';
import 'package:futsal_app/component/textfield.dart';
import 'package:futsal_app/const/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    FlutterLogo(
                      size: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    inputText('Email', Icons.email, 'email', false, email),
                    inputText(
                        'Password', Icons.lock, 'password', true, password),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_key.currentState.validate()) {
                                    Map data = {
                                      "email": email.text,
                                      "password": password.text,
                                    };

                                    var response = await Api()
                                        .loginAndRegister(data, 'login');
                                    var result = json.decode(response.body);
                                    print(result);
                                    if (result['message'] == "success") {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      preferences.setString(
                                          'token', result['token']);
                                      Navigator.popAndPushNamed(
                                          context, 'dashboard');
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (builder) {
                                            return AlertDialog(
                                              title: Text("Message"),
                                              content: Text(result['message']),
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
                                child: Text("LOGIN"))),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'register');
                      },
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'Are you new?',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: ' Register here',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                      ])),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
