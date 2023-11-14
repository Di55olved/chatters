class Cuser {
  late final String id;
  late final String about;
  late final String createdAt;
  late final bool isOnline;
  late final String lastActive;
  late final String email;
  late final String pushToken;
  late final String name;
  late final String image;

  Cuser(
      {required this.id,
      required this.about,
      required this.createdAt,
      required this.isOnline,
      required this.lastActive,
      required this.email,
      required this.pushToken,
      required this.name,
      required this.image});

  Cuser.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? " ";
    about = json['about'] ?? " ";
    createdAt = json['created_at'] ?? " ";
    isOnline = json[' is_online'] ?? " ";
    lastActive = json['last_active'] ?? " ";
    email = json['email'] ?? " ";
    pushToken = json['push_token'] ?? " ";
    name = json['name '] ?? " ";
    image = json['image '] ?? " ";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id '] = id;
    data['about'] = about;
    data['created_at'] = createdAt;
    data[' is_online'] = isOnline;
    data['last_active'] = lastActive;
    data['email'] = email;
    data['push_token'] = pushToken;
    data['name '] = name;
    data['image '] = image;
    return data;
  }
}
