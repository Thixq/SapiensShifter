// ignore_for_file: public_member_api_docs, sort_constructors_first
final class ProductModel {
  ProductModel({
    this.id,
    this.productName,
    this.description,
    this.imagePath,
    this.price,
    this.category,
    this.extrasList,
  });

  final String? id;
  final String? productName;
  final String? description;
  final String? imagePath;
  final double? price;
  final String? category;
  // TODO(kaan): Extra modelini ekle.
  final List<String>? extrasList;

  @override
  String toString() {
    return 'ProductModel(id: $id, productName: $productName, description: $description, imagePath: $imagePath, price: $price, category: $category, extrasList: $extrasList)';
  }
}
