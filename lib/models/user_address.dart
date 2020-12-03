class UserAddress {
  UserAddress({
    this.id,
    this.userid,
    this.fullname,
    this.city,
    this.district,
    this.mobile,
    this.type,
    this.cityName,
    this.address,
  });

  String id;
  String userid;
  String fullname;
  String city;
  String district;
  String mobile;
  String type;
  String cityName;
  String address;

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
        id: json["id"],
        userid: json["userid"],
        fullname: json["fullname"],
        city: json["city"],
        district: json["district"],
        mobile: json["mobile"],
        type: json["type"],
        cityName: json["city_name"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "fullname": fullname,
        "city": city,
        "district": district,
        "mobile": mobile,
        "type": type,
        "cityName": cityName,
        "address": address,
      };
}
