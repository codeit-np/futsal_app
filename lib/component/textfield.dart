import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget inputText(String label, IconData icon, String inputType, bool obsecure,
    TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
    validator: (value) => value.isEmpty ? 'required' : null,
    keyboardType: inputType == "email"
        ? TextInputType.emailAddress
        : inputType == 'phone'
            ? TextInputType.phone
            : TextInputType.text,
    obscureText: obsecure,
  );
}
