import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class UnsubscribeListModel {
  List<Data>? data;
  String? status;

  UnsubscribeListModel({this.data, this.status});

  UnsubscribeListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? unsubId;
  int? quizId;
  String? quizTitle;
  int? userId;
  DateTime? subTime;
  int? subAmount;
  DateTime? unsubTime;

  Data(
      {this.unsubId,
      this.quizId,
      this.quizTitle,
      this.userId,
      this.subTime,
      this.subAmount,
      this.unsubTime});

  Data.fromJson(Map<String, dynamic> json) {
    tzdata.initializeTimeZones(); 
    final indianTimeZone = tz.getLocation('Asia/Kolkata'); // Indian timezone

    unsubId = json['unsub_id'];
    quizId = json['quiz_id'];
    quizTitle = json['quiz_title'];
    userId = json['user_id'];
    subAmount = json['sub_amount'];

    // Parse and convert subTime to Indian Standard Time
    if (json['sub_time'] != null) {
      final subTimeUtc = DateTime.parse(json['sub_time']).toUtc();
      subTime = tz.TZDateTime.from(subTimeUtc, indianTimeZone);
    }

    // Parse and convert unsubTime to Indian Standard Time
    if (json['unsub_time'] != null) {
      final unsubTimeUtc = DateTime.parse(json['unsub_time']).toUtc();
      unsubTime = tz.TZDateTime.from(unsubTimeUtc, indianTimeZone);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unsub_id'] = this.unsubId;
    data['quiz_id'] = this.quizId;
    data['quiz_title'] = this.quizTitle;
    data['user_id'] = this.userId;
    data['sub_time'] = this.subTime?.toIso8601String();
    data['sub_amount'] = this.subAmount;
    data['unsub_time'] = this.unsubTime?.toIso8601String();
    return data;
  }
}
