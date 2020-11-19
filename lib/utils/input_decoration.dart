import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// InputDecoration buildInputDecoration(String hintText, IconData icon) {
//   return InputDecoration(
//     border: InputBorder.none,
//     icon: Icon(
//       icon,
//       color: Colors.black,
//       size: 22.0,
//     ),
//     hintText: hintText,
//     hintStyle: TextStyle(fontSize: 17.0),
//   );
// }

// InputDecoration buildInputDecorationPassword(
//     String hintText, IconData icon, suffixIcon) {
//   return InputDecoration(
//     border: InputBorder.none,
//     icon: Icon(
//       icon,
//       size: 22.0,
//       color: Colors.black,
//     ),
//     hintText: hintText,
//     hintStyle: TextStyle(fontSize: 17.0),
//     suffixIcon: Icon(
//       suffixIcon,
//       size: 15.0,
//       color: Colors.black,
//     ),
//   );
// }

// TEXTFIELD
InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}

// DROPDOWN COUNTRY CODE
InputDecoration buildDropDownDecoration() {
  return InputDecoration(
    labelStyle: TextStyle(fontSize: 12),
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}

// DROPDOWN COUNTRIES

InputDecoration buildCountriesDropDownDecoration(icon) {
  return InputDecoration(
    // labelStyle: TextStyle(fontSize: 12),
    suffixIcon: Icon(icon),
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}

// PASSWORD TEXTFIELD
InputDecoration buildInputDecorationPassword(String hintText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    suffixIcon: Icon(Icons.visibility),
    hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}
