class ProductRating {
  final double rate;
  final int count;

  ProductRating({
    required this.rate,
    required this.count,
  });

  factory ProductRating.fromJson(Map<String, dynamic> json) => ProductRating(
    rate: json['rate'],
    count: json['count'],
  );
}