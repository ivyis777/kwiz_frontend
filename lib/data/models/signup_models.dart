class SignupModel {
  String? message;
  String? status;

  SignupModel({this.message, this.status});

  SignupModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status; 
    print(data);
    return data;
  }
}
