import 'package:hani_almutairi_logistic/models/search_city.dart';

class User {
  String id;

  String firstname;
  String lastName;
  String email;
  String country = 'Saudi Arabia';
  SearchCityModel cityId;
  String district;
  String address;
  String mobileNo;
  String password;
  String confirmPassword;

  User({
    this.id,
    this.firstname,
    this.lastName,
    this.email,
    this.country,
    this.cityId,
    this.district,
    this.address,
    this.mobileNo,
    this.password,
    this.confirmPassword,
  });
}

class UserCredential {
  String mobileNo;
  String password;
  String key;

  UserCredential({this.mobileNo, this.password, this.key});
}
