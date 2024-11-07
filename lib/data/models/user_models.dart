class UserModel {
  String? message;
  String? userEmail;

  UserModel({this.message, this.userEmail});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userEmail = json['user email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user email'] = this.userEmail;
    return data;
  }
}
