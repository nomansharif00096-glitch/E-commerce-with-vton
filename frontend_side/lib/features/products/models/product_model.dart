import 'package:frontend_side/features/products/models/model.dart';

class ProductModel {
  final int id;
  final String name;
  final String price;
  final String description;
  final String stock;
  final int categoryId;
  final List<ProductImageModel>? images;
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.stock,
    required this.categoryId,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      stock: json['stock'],
      categoryId: json['categoryId'],
      images: (json['ProductImage'] as List<dynamic>?)
              ?.map((e) => ProductImageModel.fromJson(e))
              .toList() ??
          [],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "stock": stock,
        "categoryId": categoryId,
        "ProductImage": images!.map((e) => e.toJson()).toList(),
      };
}
