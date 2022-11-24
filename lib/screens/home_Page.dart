import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';

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
  int index = 0;
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xffC19E82),
            height: height * 0.35,
            child: Stack(
              children: [
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Uint8List? image = snapshot.data;
                      return Image.memory(
                        height: height * 0.35,
                        width: double.infinity,
                        image!,
                        fit: BoxFit.cover,
                        color: const Color(0xffC19E82).withOpacity(0.8),
                        colorBlendMode: BlendMode.modulate,
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("${snapshot.error}"));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.brown,
                        ),
                      );
                    }
                  },
                  future: ImageApi.imageApi.getImage(search: 'Wild Animal'),
                ),
                // FutureBuilder(
                //   future: DBHelper.dbHelper.fetchAllRecord(
                //       tableName: "ManEater", data: Global.detailsOfData),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       List? res = snapshot.data as List?;
                //       int? randomIndex = random.nextInt(res!.length);
                //       DBData randomImage = res[randomIndex];
                //
                //       return Image.memory(
                //         height: height * 0.35,
                //         width: double.infinity,
                //         randomImage.image,
                //         fit: BoxFit.cover,
                //         color: backGroundColor.withOpacity(0.8),
                //         colorBlendMode: BlendMode.modulate,
                //       );
                //     } else if (snapshot.hasError) {
                //       return Center(
                //         child: Text("${snapshot.error}"),
                //       );
                //     } else {
                //       return Center(
                //         child: CircularProgressIndicator(
                //           color: Colors.brown.shade200,
                //         ),
                //       );
                //     }
                //   },
                // ),
                CustomAppBar(),
                Container(
                  height: height * 0.38,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const Spacer(),
                      Center(
                        child: Text(
                          Strings.welcomeToAPlanet,
                          style: TextStyles.bigHeadingTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(height: height * 0.015),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // alignment: Alignment.bottomCenter,
              height: height * 0.65,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xffC19E82),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print("+++");
                        List<DBCategoryAnimalData> res = snapshot.data!;
                        return SizedBox(
                          height: height * 0.38,
                          child: ListView.builder(
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                  right: 15,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        'detail_Page',
                                        arguments: res[i]);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: height * 0.26,
                                        width: width * 0.5,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                blurRadius: 3,
                                              )
                                            ],
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    MemoryImage(res[i].image))),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        res[i].name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        res[i].description,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: res.length,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text("${snapshot.error}"));
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.brown.shade200,
                          ),
                        );
                      }
                    },
                    future: DBHelper.dbHelper.fetchAllAnimalData(
                        tableName: "animalsData", data: Global.categoryData),
                  ),
                  const Spacer(),
                  Text(
                    Strings.quickCategories,
                    style: TextStyles.titleTextStyle,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Global.category = "Dog";
                          setState(() {});
                        },
                        child: clickOptions(
                            width: width,
                            height: height,
                            name: "Dog",
                            image: "dog"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Global.category = "Snake";
                          setState(() {});
                        },
                        child: clickOptions(
                            width: width,
                            height: height,
                            name: "Snake",
                            image: "snake"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Global.category = "Elephant";
                          setState(() {});
                        },
                        child: clickOptions(
                            width: width,
                            height: height,
                            name: "Elephant",
                            image: "elephant"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
