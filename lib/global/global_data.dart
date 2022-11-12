import '../model/model.dart';
import '../style/strings.dart';

class Global {
  static List<WildAnimal> wildAnimalSplashData = [
    WildAnimal(
      price: Strings.price1,
      months: Strings.weekSubscription,
      image: "assets/image/weekly.jpg",
    ),
    WildAnimal(
      price: Strings.price2,
      months: Strings.oneMonthSubscription,
      image: "assets/image/monthly.jpg",
    ),
    WildAnimal(
      price: Strings.price3,
      months: Strings.threeMonthSubscription,
      image: "assets/image/3monthly.jpg",
    ),
    WildAnimal(
      price: Strings.price4,
      months: Strings.sixMonthSubscription,
      image: "assets/image/6monthly.jpg",
    ),
  ];
  static List<WildAnimal> images = [
    WildAnimal(
      image: "assets/image/lion.jpg",
    ),
    WildAnimal(
      image: "assets/image/Elephant.jpg",
    ),
    WildAnimal(
      image: "assets/image/elepent.jpg",
    ),
    WildAnimal(
      image: "assets/image/Lion.jpg",
    ),
    WildAnimal(
      image: "assets/image/cobras.jpg",
    ),
    WildAnimal(
      image: "assets/image/Snake.jpg",
    ),
    WildAnimal(
      image: "assets/image/Cat.jpg",
    ),
    WildAnimal(
      image: "assets/image/Panda.jpg",
    ),
  ];
  static String category = "";
  static List<WildAnimal> animalData = [
    WildAnimal(
      name: "Elephant",
      description: Strings.loremIpsum,
      category: "Elephant",
    ),
    WildAnimal(
      name: "elepent",
      description: Strings.loremIpsum,
      category: "Elephant",
    ),
    WildAnimal(
      name: "Lion",
      description: Strings.loremIpsum,
      category: "Lion",
    ),
    WildAnimal(
      name: "cobras",
      description: Strings.loremIpsum,
      category: "Snake",
    ),
    WildAnimal(
      name: "Snake",
      description: Strings.loremIpsum,
      category: "Snake",
    ),
    WildAnimal(
      name: "cat",
      description: Strings.loremIpsum,
      category: "Pets",
    ),
    WildAnimal(
      name: "panda",
      description: Strings.loremIpsum,
      category: "Pets",
    ),
  ];
}
