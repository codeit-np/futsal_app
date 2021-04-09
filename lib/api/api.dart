import 'dart:convert';

import 'package:futsal_app/const/const.dart';
import 'package:http/http.dart' as http;

class Api {
  //Login and Register
  Future loginAndRegister(Map data, String endPoint) async {
    String url = baseURL + endPoint;
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(data));
    return response;
  }

  //Post
  Future postData(Map data, String endPoint) async {
    String url = baseURL + endPoint;
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(data));
    return response;
  }

  //Get
  Future getData(String endPoint) async {
    String url = baseURL + endPoint;
    var response = await http.get(
      Uri.parse(url),
      headers: {'Accept': 'application/json'},
    );
    return response;
  }
  //Logout
}
