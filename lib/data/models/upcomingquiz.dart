class UpcomingKwiizzesModel {
  String? message;
  String? title;

  UpcomingKwiizzesModel({this.message, this.title});

  UpcomingKwiizzesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['title'] = this.title;
    return data;
  }
}
