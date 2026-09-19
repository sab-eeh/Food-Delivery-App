class FoodModel {
  final String id;
  final String name;
  final String image;
  final String description;
  final double price;

  FoodModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });

  factory FoodModel.fromFirestore(Map<String, dynamic> data, String id) {
    return FoodModel(
      id: id,
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] as num).toDouble(),
    );
  }
}
