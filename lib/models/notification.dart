class NotificationMessage {
  NotificationMessage({
    this.id,
    this.userid,
    this.text,
    this.isread,
    this.heading,
  });

  String id;
  String userid;
  String text;
  String isread;
  String heading;

  factory NotificationMessage.fromJson(Map<String, dynamic> json) =>
      NotificationMessage(
        id: json["id"],
        userid: json["userid"],
        text: json["text"],
        isread: json["isread"],
        heading: json["heading"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "text": text,
        "isread": isread,
        "heading": heading,
      };
}
