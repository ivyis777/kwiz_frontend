class QuestionData {
  int? quesId;
  String? quesTitle;
  String? quesType;

  QuestionData({this.quesId, this.quesTitle, this.quesType});

  QuestionData.fromJson(Map<String, dynamic> json) {
    quesId = json['ques_id'];
    quesTitle = json['ques_title'];
    quesType = json['ques_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ques_id'] = this.quesId;
    data['ques_title'] = this.quesTitle;
    data['ques_type'] = this.quesType;
    return data;
  }
}