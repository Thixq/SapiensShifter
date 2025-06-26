// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

final class NotificationDetailModel {
  NotificationDetailModel(this.title, this.body, this.channelId, this.route);

  final String? title;
  final String? body;
  final String? channelId;
  final String? route;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'channelId': channelId,
      'route': route,
    };
  }

  factory NotificationDetailModel.fromMap(Map<String, dynamic> map) {
    return NotificationDetailModel(
      map['title'] != null ? map['title'] as String : null,
      map['body'] != null ? map['body'] as String : null,
      map['channelId'] != null ? map['channelId'] as String : null,
      map['route'] != null ? map['route'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationDetailModel.fromJson(String source) =>
      NotificationDetailModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
