class Messages {
  String msg;
  String toId;
  String read;
  Type type;
  String sent;
  String fromId;

  Messages.fromJson(Map<String, dynamic> json)
      : msg = json['msg'].toString(),
        toId = json['toId'].toString(),
        read = json['read'].toString(),
        type = _getTypeFromJson(json['type'].toString()),
        sent = json['sent'].toString(),
        fromId = json['fromId'].toString();

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = msg;
    _data['toId'] = toId;
    _data['read'] = read;
    _data['type'] = type.toString().split('.').last;
    _data['sent'] = sent;
    _data['fromId'] = fromId;
    return _data;
  }

  static Type _getTypeFromJson(String type) =>
      type == Type.image.toString() ? Type.image : 
      type == Type.video.toString() ? Type.video : 
      Type.text;
}

enum Type {
  text,
  image,
  video
}
