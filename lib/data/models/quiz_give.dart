

import 'package:Kwiz/data/models/questions_data.dart';

class QuizGive {
  List<QuestionsData>? questionsData;

  QuizGive({this.questionsData});

  QuizGive.fromJson(Map<String, dynamic> json) {
    if (json['questions_data'] != null) {
      questionsData = <QuestionsData>[];
      json['questions_data'].forEach((v) {
        questionsData!.add(new QuestionsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questionsData != null) {
      data['questions_data'] =
          this.questionsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}





