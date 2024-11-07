class UserDetailsModel {
  List<UserId>? userId;

  UserDetailsModel({this.userId});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['user_id'] != null) {
      userId = <UserId>[];
      json['user_id'].forEach((v) {
        userId!.add(new UserId.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userId != null) {
      data['user_id'] = this.userId!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserId {
  int? id;
  String? name;
  String? gender;
  String? email;
  String? mobile;
  String? address;
  String? city;
  String? country;
  String? state;
  int? pincode;
  int? age;
  // String? image;

  UserId(
      {this.id,
      this.name,
      this.gender,
      this.email,
      this.mobile,
      this.address,
      this.city,
      this.country,
      this.state,
      this.pincode,
      this.age,
      // this.image
      });

  UserId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    pincode = json['pincode'];
    age = json['age'];
    // image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['age'] = this.age;
    // data['image'] = this.image;
    return data;
  }
}
