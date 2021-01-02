// class City {
//   City({
//     this.cityId,
//     this.cityName,
//   });

//   String cityId;
//   String cityName;

//   factory City.fromJson(Map<String, dynamic> json) => City(
//         cityId: json["city_id"],
//         cityName: json["city_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "city_id": cityId,
//         "city_name": cityName,
//       };
// }

class City {
  City({
    this.cityId,
    this.cityName,
    this.cityArabicName,
  });

  String cityId;
  String cityName;
  String cityArabicName;

  factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json["city_id"],
        cityName: json["city_name"],
        cityArabicName: json["city_arabic_name"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "city_name": cityName,
        "city_arabic_name": cityArabicName,
      };
}
