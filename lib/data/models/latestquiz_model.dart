class LatestKwiizzesModel {
  String? message;
  String? title;

  LatestKwiizzesModel ({this.message, this.title});

 LatestKwiizzesModel .fromJson(Map<String, dynamic> json) {
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
