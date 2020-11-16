class Property {
  String id,
      name,
      city,
      address,
      comment,
      type,
      lastPayment,
      nextPayment,
      createdOn,
      userId,
      typeName;

  List<PropertyImage> images;

  Property({
    this.id,
    this.name,
    this.city,
    this.address,
    this.comment,
    this.type,
    this.lastPayment,
    this.nextPayment,
    this.createdOn,
    this.userId,
    this.typeName,
    this.images,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      address: json['address'],
      comment: json['comment'],
      type: json['type'],
      lastPayment: json['last_payment'],
      nextPayment: json['next_payment'],
      createdOn: json['created_on'],
      userId: json['userId'],
      typeName: json['type_name'],
      images: (json['images'] as List)
          .map((i) => PropertyImage.fromJson(i))
          .toList(),
    );
  }
}

class PropertyImage {
  String id, url, pImageTitle, propertyId, front;

  PropertyImage({
    this.id,
    this.url,
    this.pImageTitle,
    this.propertyId,
    this.front,
  });

  factory PropertyImage.fromJson(Map<String, dynamic> json) {
    return PropertyImage(
      id: json['id'],
      url: json['url'],
      pImageTitle: json['p_image_title'],
      propertyId: json['property_id'],
      front: json['front'],
    );
  }
}


class UserProperty {
  String id,
      name,
      city,
      address,
      comment,
      type,
      lastPayment,
      nextPayment,
      createdOn,
      userId,
      typeName;


  UserProperty({
    this.id,
    this.name,
    this.city,
    this.address,
    this.comment,
    this.type,
    this.lastPayment,
    this.nextPayment,
    this.createdOn,
    this.userId,
    this.typeName,
  });

  factory UserProperty.fromJson(Map<String, dynamic> json) {
    return UserProperty(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      address: json['address'],
      comment: json['comment'],
      type: json['type'],
      lastPayment: json['last_payment'],
      nextPayment: json['next_payment'],
      createdOn: json['created_on'],
      userId: json['userId'],
      typeName: json['type_name'],
    
    );
  }
}
