import 'user.dart';

class LISTCHAT {
  List<CHAT>? listchat;

  LISTCHAT({this.listchat});

  LISTCHAT.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      listchat = <CHAT>[];
      json['results'].forEach((v) {
        listchat!.add(new CHAT.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listchat != null) {
      data['results'] = this.listchat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CHAT {
  String? id;
  String? text;
  USER? user;
  int? replyCount;
  int? unreadCount;
  String? createdAt;

  CHAT(
      {this.id,
        this.text,
        this.user,
        this.replyCount,
        this.unreadCount,
        this.createdAt});

  CHAT.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    user = json['user'] != null ? new USER.fromJson(json['user']) : null;
    replyCount = json['reply_count'];
    unreadCount = json['unread_count'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['reply_count'] = this.replyCount;
    data['unread_count'] = this.unreadCount;
    data['created_at'] = this.createdAt;
    return data;
  }
}
