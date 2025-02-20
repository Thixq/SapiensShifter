abstract class IBaseModel<T> {
  const IBaseModel();
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
