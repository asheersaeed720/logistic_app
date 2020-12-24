class SearchBankModel {
  final String id;
  final String name;

  SearchBankModel({
    this.id,
    this.name,
  });

  factory SearchBankModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return SearchBankModel(
      id: json["id"].toString(),
      name: json["name"].toString(),
    );
  }

  static List<SearchBankModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => SearchBankModel.fromJson(item)).toList();
  }

  String userAsString() {
    return '#${this.id} ${this.name}';
  }

  @override
  String toString() {
    return id + name;
  }
}
