import 'package:hani_almutairi_logistic/models/search_city.dart';

class User {
  String firstname;
  String lastName;
  String country = 'Saudi Arabia';
  SearchCityModel city;
  String district;
  num mobileNo;
  String password;
  String confirmPassword;

  User({
    firsname,
    lastName,
    country,
    city,
    district,
    mobileNo,
    password,
    confirmPassword,
  });
}

class UserCredential {
  String mobileNo;
  String password;

  UserCredential({this.mobileNo, this.password});
}
