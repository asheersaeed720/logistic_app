class City {
  City({
    this.cityId,
    this.cityName,
  });

  String cityId;
  String cityName;

  factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json["city_id"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "city_name": cityName,
      };
}
