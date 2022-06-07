class LISTUSER {
  List<USER>? listuser;

  LISTUSER({this.listuser});

  LISTUSER.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      listuser = <USER>[];
      json['results'].forEach((v) {
        listuser!.add(new USER.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listuser != null) {
      data['results'] = this.listuser!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class USER {
  String? gender;
  String? name;
  String? email;
  String? dob;
  String? registered;
  String? phone;
  String? status;
  Picture? picture;

  USER(
      {this.gender,
        this.name,
        this.email,
        this.dob,
        this.registered,
        this.phone,
        this.status,
        this.picture});

  USER.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    name = json['name'];
    email = json['email'];
    dob = json['dob'];
    registered = json['registered'];
    phone = json['phone'];
    status = json['status'];
    picture =
    json['picture'] != null ? new Picture.fromJson(json['picture']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['name'] = this.name;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['registered'] = this.registered;
    data['phone'] = this.phone;
    data['status'] = this.status;
    if (this.picture != null) {
      data['picture'] = this.picture!.toJson();
    }
    return data;
  }
}

class Picture {
  String? large;
  String? medium;
  String? thumbnail;

  Picture({this.large, this.medium, this.thumbnail});

  Picture.fromJson(Map<String, dynamic> json) {
    large = json['large'];
    medium = json['medium'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['large'] = this.large;
    data['medium'] = this.medium;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
