import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_model.g.dart';

@JsonSerializable(checked: true)
final class BranchModel extends IBaseModel<BranchModel> {
  BranchModel({super.id, this.name, this.address});

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);

  final String? name;
  final String? address;

  @override
  Map<String, dynamic> toJson() => _$BranchModelToJson(this);

  @override
  BranchModel fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);
}
