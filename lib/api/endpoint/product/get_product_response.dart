import 'package:yoshua_ui_test/api/endpoint/product/get_product_response_data_rating.dart';

class ProductResponse {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final ProductRating? rating;



  ProductResponse({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating


  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    ProductRating? data;

    if (json['rating'] != null) {
      data = ProductRating.fromJson(json['rating']);
    }


    return ProductResponse(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: data

    );
  }
}