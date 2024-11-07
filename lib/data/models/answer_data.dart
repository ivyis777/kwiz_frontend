class AnswerData {
  int? answerId;
  String? options;
  int? quesId;

  AnswerData({this.answerId, this.options, this.quesId});

  AnswerData.fromJson(Map<String, dynamic> json) {
    answerId = json['answer_id'];
    options = json['options'];
    quesId = json['ques_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer_id'] = this.answerId;
    data['options'] = this.options;
    data['ques_id'] = this.quesId;
    return data;
  }
}
