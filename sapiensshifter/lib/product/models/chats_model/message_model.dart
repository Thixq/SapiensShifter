import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiensshifter/product/utils/json_converters/timestamp_converter.dart';

part 'message_model.g.dart';

@JsonSerializable(checked: true)
class MessageModel extends IBaseModel<MessageModel> with EquatableMixin {
  MessageModel(this.senderId, this.message, this.timeStamp);

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  final String? senderId;
  final String? message;
  @TimestampNullableConverter()
  final DateTime? timeStamp;

  @override
  MessageModel fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  @override
  // TODO: implement props
  List<Object?> get props => [
        senderId,
        message,
        timeStamp,
      ];

  @override
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  @override
  String toString() {
    return 'Message: {senderId: $senderId, message: $message, timeStamp: $timeStamp}';
  }
}
