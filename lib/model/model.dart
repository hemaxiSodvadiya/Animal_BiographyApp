// class WildAnimal {
//   String? name;
//   String? image;
//   String? description;
//   String? place;
//   String? common;
//   String? height;
//   String? weight;
//   String? vol;
//
//   WildAnimal({
//     this.name,
//     this.image,
//     this.description,
//     this.place,
//     this.common,
//     this.height,
//     this.weight,
//     this.vol,
//   });
//
//   factory WildAnimal.fromMap({required Map jsonData}) {
//     return WildAnimal(
//       name: jsonData['name'],
//       description: jsonData['description'],
//       place: jsonData['place'],
//       common: jsonData['common'],
//       height: jsonData['height'],
//       weight:
//     );
//   }
// }
import 'dart:typed_data';

class WildAnimal {
  String? months;
  String? price;
  String? image;
  String? name;
  String? description;
  String? category;
  Uint8List? images;

  WildAnimal({
    this.months,
    this.price,
    this.image,
    this.name,
    this.description,
    this.category,
    this.images,
  });

  factory WildAnimal.fromJson({required Map jsonData}) {
    return WildAnimal(
      months: jsonData['months'],
      price: jsonData['price'],
      image: jsonData['image'],
      name: jsonData['name'],
      description: jsonData['description'],
      category: jsonData['category'],
      images: jsonData['images'],
    );
  }
}
