class SearchCityModel {
  final String name;

  SearchCityModel({
    this.name,
  });

  factory SearchCityModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return SearchCityModel(
      name: json["name"],
    );
  }

  static List<SearchCityModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => SearchCityModel.fromJson(item)).toList();
  }

  String userAsString() {
    return '#${this.name}';
  }

  @override
  String toString() => name;
}
