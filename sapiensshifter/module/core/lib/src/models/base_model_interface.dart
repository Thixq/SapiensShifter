abstract class BaseModelInterface<T> {
  const BaseModelInterface();
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
