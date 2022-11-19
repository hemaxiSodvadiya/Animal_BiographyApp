import 'dart:ui';

import '../model/model.dart';
class Global {
  static Color color = const Color(0xffC19E82);

  static List<AnimalData> detailsOfData = [
    AnimalData(time: "Week", price: "1.99"),
    AnimalData(time: "1 Month", price: "4.39"),
    AnimalData(time: "3 Month", price: "9.99"),
    AnimalData(time: "6 Month", price: "13"),
  ];
  static String category = "";
  static List<Animal> animalData = [
    Animal(
      name: "Python family",
      description: "Pythonidae",
      category: "Snake",
    ),
    Animal(
      name: "Cobras",
      description: "Naja",
      category: "Snake",
    ),
    Animal(
      name: "German Shepherd",
      description: "German Shepherd",
      category: "Dog",
    ),
    Animal(
      name: "Siberian Husky",
      description: "Husky; Sibe",
      category: "Dog",
    ),
    Animal(
      name: "African elephant",
      description: "Loxodonta",
      category: "Elephant",
    ),
    Animal(
      name: "Elephant",
      description: "Large Rounded Ears",
      category: "Elephant",
    ),
  ];
}

