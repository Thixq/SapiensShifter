import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'android_channel_model.g.dart';

@JsonSerializable(checked: true)
class AndroidChannelModel extends IBaseModel<AndroidChannelModel> {
  AndroidChannelModel(
    this.channelId,
    this.channelName,
    this.channelDescription,
  );

  factory AndroidChannelModel.fromJson(Map<String, dynamic> json) =>
      _$AndroidChannelModelFromJson(json);

  final String? channelId;
  final String? channelName;
  final String? channelDescription;

  @override
  AndroidChannelModel fromJson(Map<String, dynamic> json) =>
      _$AndroidChannelModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AndroidChannelModelToJson(this);
}
