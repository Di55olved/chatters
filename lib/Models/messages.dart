class Messages {
  Messages ({
  required String msg,
  required String toId,
  required String read,
  required Type type,
  required String sent,
  required String fromId,
  });

  late final String toId;
  late final String msg;
  late final String read;
  late final String fromId;
  late final String sent;
  late final Type type;

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
//generic: to change message attribute type dynamically 

  static Type _getTypeFromJson(String type) =>
      type == Type.image.toString() ? Type.image : 
      type == Type.video.toString() ? Type.video : 
      Type.text;
}
//generic: to change message attribute type dynamically 
enum Type {
  text,
  image,
  video
}
