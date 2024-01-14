import 'package:yoshua_ui_test/api/endpoint/product/get_product_response_data_rating.dart';

import 'add_new_cart_request_data.dart';

class GetCartResponse {
  final int id;
  final int userId;
  final String date;
  final List<CartProductItem> product;


  GetCartResponse({
    required this.id,
    required this.userId,
    required this.date,
    required this.product,

  });

  factory GetCartResponse.fromJson(Map<String, dynamic> json) {
    List<CartProductItem> data = [];

    if (json['products'] != null) {
      json['products'].forEach((v) {
        data.add(CartProductItem.fromJson(v));
      });
    }


    return GetCartResponse(
        id: json['id'],
        userId: json['userId'],
        date: json['date'],
        product: data

    );
  }
}