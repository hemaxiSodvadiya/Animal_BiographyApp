import 'dart:ui';

import '../model/model.dart';

class Global {
  static List<ChooseAnimalData> detailsOfData = [
    ChooseAnimalData(
      time: "Week",
      price: "1.99",
    ),
    ChooseAnimalData(
      time: "1 Month",
      price: "4.39",
    ),
    ChooseAnimalData(
      time: "3 Month",
      price: "9.99",
    ),
    ChooseAnimalData(
      time: "6 Month",
      price: "13",
    ),
  ];
  static String category = "";

  static List<CategoryAnimalData> categoryData = [
    CategoryAnimalData(
      name: "elephant",
      description: "Loxodonta",
      category: "Elephant",
    ),
    CategoryAnimalData(
      name: "Cobras",
      description: "cobras Snake",
      category: "Snake",
    ),
    CategoryAnimalData(
      name: "fox",
      description: "Wild fox",
      category: "Dog",
    ),
    CategoryAnimalData(
      name: "white_fox",
      description: "white_fox",
      category: "Dog",
    ),
  ];
}
