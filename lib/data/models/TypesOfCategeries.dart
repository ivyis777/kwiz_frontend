class TypesOfCategariesModel {
  int? quizTypeId;
  String? quizType;
  String? image;

  TypesOfCategariesModel({this.quizTypeId, this.quizType, this.image});

  TypesOfCategariesModel.fromJson(Map<String, dynamic> json) {
    quizTypeId = json['quiz_type_id'];
    quizType = json['quiz_type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quiz_type_id'] = this.quizTypeId;
    data['quiz_type'] = this.quizType;
    data['image'] = this.image;
    return data;
  }
}
