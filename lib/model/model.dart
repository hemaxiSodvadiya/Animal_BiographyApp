import 'dart:typed_data';

class AnimalData {
  final String time;
  final String price;

  AnimalData({required this.time, required this.price});
}

class DBData {
  final String time;
  final String price;
  final Uint8List image;
  DBData({required this.time, required this.price, required this.image});
  factory DBData.fromData(e) {
    return DBData(time: e['time'], price: e['price'], image: e['image']);
  }
}

class Animal {
  final String name;
  final String description;
  final String category;

  Animal(
      {required this.name, required this.category, required this.description});
}

class DBAnimal {
  final String name;
  final String description;
  final String category;
  final Uint8List image;

  DBAnimal(
      {required this.name,
      required this.category,
      required this.description,
      required this.image});

  factory DBAnimal.fromData(Map data) {
    return DBAnimal(
        name: data["name"],
        category: data["category"],
        description: data["description"],
        image: data['image']);
  }
}
