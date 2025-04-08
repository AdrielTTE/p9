class ProductModel{
  final int id;
  final String description;
  final double price;
  final String img;

  ProductModel({
    required this.id,
    required this.description,
    required this.price,
    required this.img,
  });

  factory ProductModel.fromJson(Map<String, dynamic>data) => ProductModel(
    id: data['id'],
    description: data['description'],
    price: data['price'],
    img: data['img'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'description': description,
    'price': price,
    'img': img,
  };


}