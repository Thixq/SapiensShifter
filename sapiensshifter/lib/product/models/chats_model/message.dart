import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/utils/json_converters/timestamp_converter.dart';

part 'message.g.dart';

@JsonSerializable(checked: true)
class Message extends IBaseModel<Message> with EquatableMixin {
  Message({super.id, this.senderId, this.text, this.timeStamp});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  final String? senderId;
  final String? text;
  @TimestampNullableConverter()
  final DateTime? timeStamp;

  @override
  Message fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  @override
  List<Object?> get props => [
        id,
      ];

  @override
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  String toString() {
    return 'Message: {textId: $id, senderId: $senderId, message: $text, timeStamp: $timeStamp}';
  }
}
