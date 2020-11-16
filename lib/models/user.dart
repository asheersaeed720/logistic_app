class User {
  User({
    this.error,
    this.token,
    this.userId,
    this.userInfo,
  });

  bool error;
  String token;
  String userId;
  // List<UserInfo> userInfo;
  List<dynamic> userInfo;

  factory User.fromJson(Map<String, dynamic> json) => User(
        error: json["error"],
        token: json["token"],
        userId: json["user_id"].toString(),
        userInfo:
            List<UserInfo>.from(json["user"].map((i) => UserInfo.fromJson(i))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "token": token,
        "user_id": userId,
        "user": List<dynamic>.from(userInfo.map((i) => i.toJson())),
      };
}

class UserInfo {
  UserInfo({
    this.id,
    this.name,
    this.phone,
    this.username,
    this.email,
    this.password,
    this.lastLogin,
    this.type,
  });

  String id;
  String name;
  String phone;
  String username;
  String email;
  String password;
  DateTime lastLogin;
  String type;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        lastLogin: DateTime.parse(json["last_login"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "username": username,
        "email": email,
        "password": password,
        "last_login": lastLogin.toIso8601String(),
        "type": type,
      };
}
