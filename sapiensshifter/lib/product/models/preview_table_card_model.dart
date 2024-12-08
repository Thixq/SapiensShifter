// ignore_for_file: public_member_api_docs, sort_constructors_first
class PreviewTableCardModel {
  PreviewTableCardModel({
    this.id,
    this.tableName,
    this.timeStamp,
    this.creatorId,
    this.branchName,
    this.peopleCount,
    this.status,
    this.closingTime,
    this.orderList,
  });
  String? id;
  String? tableName;
  DateTime? timeStamp;
  String? creatorId;
  String? branchName;
  int? peopleCount;
  bool? status;
  DateTime? closingTime;
  // TODO(kaan): Order model ile değiştir.
  List<String>? orderList;

  String get getCreateClock =>
      // ignore: lines_longer_than_80_chars
      '${timeStamp?.hour.toString().padLeft(2, '0') ?? '--'}:${timeStamp?.minute.toString().padLeft(2, '0') ?? '--'}';
}
