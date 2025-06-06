abstract class IBaseModel<T> {
  const IBaseModel({this.id});
  final String? id;
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
