class CartProductItem {
   int productId;
   int quantitiy;

  CartProductItem({
    required this.productId,
    required this.quantitiy,

  });

  factory CartProductItem.fromJson(Map<String, dynamic> json) {
    return CartProductItem(
      productId: json['productId'],
      quantitiy: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic> {
    'productId': this.productId,
    'quantitiy': this.quantitiy,

  };
}