class LoginModel {
  String? message;
  String? userEmail;
  bool? isCreator;
  String? username;
  String? name;
  int ?userId;
  int ?companyId;
  int ?branchId;
  String ?status;
  bool? throughGoogle;
  String? token;

  LoginModel(
      {this.message,
      this.userEmail,
      this.isCreator,
      this.username,
      this.name,
      this.userId,
      this.companyId,
      this.branchId,
      this.status,
      this.throughGoogle,
      this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userEmail = json['user email'];
    isCreator = json['is_creator'];
    username = json['username'];
    name = json['name'];
    userId = json['user id'];
    companyId = json['company_id'];
    branchId = json['branch id'];
    status = json['status'];
    throughGoogle = json['through_google'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user email'] = this.userEmail;
    data['is_creator'] = this.isCreator;
    data['username'] = this.username;
    data['name'] = this.name;
    data['user id'] = this.userId;
    data['company_id'] = this.companyId;
    data['branch id'] = this.branchId;
    data['status'] = this.status;
    data['through_google'] = this.throughGoogle;
    data['token'] = this.token;
    return data;
  }
}
