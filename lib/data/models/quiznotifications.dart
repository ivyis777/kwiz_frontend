import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;

class QuizNotificationsModel {
  int? id;
  String? title;
  String? message;
  String? timestamp;

  QuizNotificationsModel({this.id, this.title, this.message, this.timestamp});

  QuizNotificationsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['timestamp'] = this.timestamp;
    return data;
  }

  /// Get the timestamp in IST as a formatted string
  String? getTimestampInIST() {
    if (timestamp == null) {
      return null;
    }

    // Initialize time zone data
    tz.initializeTimeZones();
    final indiaTimeZone = tz.getLocation('Asia/Kolkata');

    // Parse the original timestamp
    DateTime utcTime = DateTime.parse(timestamp!).toUtc();

    // Convert to IST
    final istTime = tz.TZDateTime.from(utcTime, indiaTimeZone);

    // Format the time as needed, e.g., 'yyyy-MM-dd HH:mm:ss'
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(istTime);
  }

  /// Get the timestamp as a DateTime object for sorting
  DateTime? getTimestampAsDateTime() {
    if (timestamp == null) {
      return null;
    }
    try {
      return DateTime.parse(timestamp!).toUtc(); // Parse as UTC DateTime
    } catch (e) {
      print('Error parsing timestamp: $e');
      return null;
    }
  }
}
