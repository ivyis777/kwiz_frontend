class RecentQuizModel {
  String? name;
  String? result;

  RecentQuizModel({this.name, this.result});

  RecentQuizModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['result'] = this.result;
    print(data);
    return data;
  }
}
