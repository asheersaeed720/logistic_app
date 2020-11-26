import 'package:hani_almutairi_logistic/models/search_city.dart';

class User {
  String id;
  String firstname;
  String lastName;
  String country = 'Saudi Arabia';
  SearchCityModel cityId;
  String district;
  String mobileNo;
  String password;
  String confirmPassword;

  User({
    this.id,
    this.firstname,
    this.lastName,
    this.country,
    this.cityId,
    this.district,
    this.mobileNo,
    this.password,
    this.confirmPassword,
  });
}

class UserCredential {
  String mobileNo;
  String password;

  UserCredential({this.mobileNo, this.password});
}
