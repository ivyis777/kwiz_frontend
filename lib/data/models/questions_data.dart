

import 'package:Kwiz/data/models/answer_data.dart';
import 'package:Kwiz/data/models/question_data.dart';

class QuestionsData {
  QuestionData? questionData;
  List<AnswerData>? answerData;

  QuestionsData({this.questionData, this.answerData});

  QuestionsData.fromJson(Map<String, dynamic> json) {
    questionData = json['question_data'] != null
        ? new QuestionData.fromJson(json['question_data'])
        : null;
    if (json['answer_data'] != null) {
      answerData = <AnswerData>[];
      json['answer_data'].forEach((v) {
        answerData!.add(new AnswerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questionData != null) {
      data['question_data'] = this.questionData!.toJson();
    }
    if (this.answerData != null) {
      data['answer_data'] = this.answerData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}