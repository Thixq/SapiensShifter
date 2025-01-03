class ProductModel {
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
}
