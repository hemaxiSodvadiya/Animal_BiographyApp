import 'package:flutter/material.dart';
import 'dart:typed_data';
import '../common/custom_app_bar.dart';
import '../common/options_container.dart';
import '../global/global_data.dart';
import '../helper/db_helpers.dart';
import '../helper/splash_api.dart';
import '../model/model.dart';
import '../style/strings.dart';
import '../style/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFB98959).withOpacity(0.6),
      body: Stack(
        children: [
          Container(
            height: height * 0.46,
            child: Stack(
              children: [
                FutureBuilder(
                  future: SplashHelper.splashHelper.splashImage(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Uint8List? image = snapshot.data;
                      return Image.memory(
                        height: height * 0.50,
                        width: double.infinity,
                        image!,
                        fit: BoxFit.cover,
                        color: Colors.teal.withOpacity(0.8),
                        colorBlendMode: BlendMode.modulate,
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("${snapshot.error}"));
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                Column(
                  children: <Widget>[
                    CustomAppBar(
                      opacity: 1,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment(0, -0.6),
                        child: Text(
                          Strings.welcomeToAPlanet,
                          style: TextStyles.bigHeadingTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.63,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFB98959),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                    future: DbHelper.dbHelper
                        .fetchAllRespons(data: Global.wildAnimalSplashData),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        List<WildAnimal>? res = snapShot.data;

                        print("+++++++");
                        return SizedBox(
                          height: height * 0.39,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: Global.images.length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                  right: 15,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: height * 0.26,
                                      width: width * 0.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 3,
                                          )
                                        ],
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "${Global.images[i].image}"),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      child: Text(
                                        Strings.lifeWithATiger,
                                        style: TextStyles.titleTextStyle,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      child: Text(
                                        Strings.loremIpsum,
                                        style: TextStyles.body3TextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else if (snapShot.hasError) {
                        return Center(child: Text("${snapShot.error}"));
                      } else {
                        return Container(
                          color: Colors.red,
                        );
                      }
                    },
                  ),
                  Text(
                    Strings.quickCategories,
                    style: TextStyles.titleTextStyle,
                  ),
                  const SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          setState(() {});
                        },
                        child: clickOptions(
                          name: "Elephant",
                          image: "elephant",
                          height: height,
                          width: width,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Global.category = "Lion";
                          setState(() {});
                        },
                        child: clickOptions(
                          name: "Lion",
                          image: "lion",
                          height: height,
                          width: width,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Global.category = "Snake";
                          setState(() {});
                        },
                        child: clickOptions(
                          name: "Snake",
                          image: "snake",
                          height: height,
                          width: width,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Global.category = "Pets";
                          setState(() {});
                        },
                        child: clickOptions(
                          name: "Pets",
                          image: "pets",
                          height: height,
                          width: width,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
