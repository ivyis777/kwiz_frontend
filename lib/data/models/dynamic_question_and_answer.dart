

import 'package:Kwiz/data/models/question_data.dart';

import 'answer_data.dart';

class DynamicQuestionAndAnswer {
  List<QuestionData>? questionData;
  List<AnswerData>? answerData;

  DynamicQuestionAndAnswer({this.questionData, this.answerData});

  DynamicQuestionAndAnswer.fromJson(Map<String, dynamic> json) {
    if (json['question data'] != null) {
      questionData = <QuestionData>[];
      json['question data'].forEach((v) {
        questionData!.add(new QuestionData.fromJson(v));
      });
    }
    if (json['answer data'] != null) {
      answerData = <AnswerData>[];
      json['answer data'].forEach((v) {
        answerData!.add(new AnswerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questionData != null) {
      data['question_data'] =
          this.questionData!.map((v) => v.toJson()).toList();
    }
    if (this.answerData != null) {
      data['answer_data'] = this.answerData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




