class Product {
  final int id;
  final String title;
  final num price;

  Product({required this.id, required this.title, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) =>
      Product(id: json['id'], title: json['title'], price: json['price']);
}
