// TODO(kaan): adını değiştir.
abstract class ProductBaseModelInterface<T> {
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
