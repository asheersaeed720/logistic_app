class SearchCityModel {
  final String id;
  final String name;

  SearchCityModel({
    this.id,
    this.name,
  });

  factory SearchCityModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return SearchCityModel(
      id: json["city_id"].toString(),
      name: json["city_name"].toString(),
    );
  }

  static List<SearchCityModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => SearchCityModel.fromJson(item)).toList();
  }

  String userAsString() {
    return '#${this.id} ${this.name}';
  }

  @override
  String toString() {
    return id + name;
  }
}
