import 'dart:typed_data';

class ChooseAnimalData {
  final String time;
  final String price;

  ChooseAnimalData({required this.time, required this.price});
}


class CategoryAnimalData {
  final String name;
  final String description;
  final String category;

  CategoryAnimalData(
      {required this.name, required this.category, required this.description});
}








class DBChooseAnimalData {
  final String time;
  final String price;
  final Uint8List image;
  DBChooseAnimalData(
      {required this.time, required this.price, required this.image});
  factory DBChooseAnimalData.fromData(e) {
    return DBChooseAnimalData(
        time: e['time'], price: e['price'], image: e['image']);
  }
}

class DBCategoryAnimalData {
  final String name;
  final String description;
  final String category;
  final Uint8List image;

  DBCategoryAnimalData(
      {required this.name,
      required this.category,
      required this.description,
      required this.image});

  factory DBCategoryAnimalData.fromData(Map data) {
    return DBCategoryAnimalData(
        name: data["name"],
        category: data["category"],
        description: data["description"],
        image: data['image']);
  }
}
