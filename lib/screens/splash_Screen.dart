import 'dart:math';

import 'package:flutter/material.dart';

import '../common/custom_app_bar.dart';
import '../global/global_data.dart';
import '../helper/db_helpers.dart';
import '../model/model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int index = 0;
  Random random = Random();

  @override
  void initState() {
    super.initState();
    Future<List<DBData>> details = DBHelper.dbHelper
        .fetchAllRecord(tableName: "Splash", data: Global.detailsOfData);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
 
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      body: SafeArea(
          child: IndexedStack(
        index: index,
        children: [
          Stack(
            children: [
              FutureBuilder(
                future: DBHelper.dbHelper.fetchAllRecord(
                    tableName: "ManEater", data: Global.detailsOfData),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List? res = snapshot.data as List?;
                    int? randomIndex = random.nextInt(res!.length);
                    DBData randomImage = res[randomIndex];

                    return Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          color: const Color(0xffC19E82),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              opacity: 0.4,
                              image: MemoryImage(
                                randomImage.image,
                              ))),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.brown,
                      ),
                    );
                  }
                },
              ),
              Column(
                children: [
                  CustomAppBar(),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 32.0,
                      left: 32,
                      right: 32,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Ready to watch?",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(text: "\n"),
                          TextSpan(
                              text:
                                  "A planet is a global leader in real life entertainment, serving a passionate audience of superfans around the world with content that inspires, informs and entertains.",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              )),
                          TextSpan(text: "\n"),
                          TextSpan(text: "\n"),
                          TextSpan(
                            text: "Start Enjoying",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).pushNamed('choose_Page');
                    });
                  },
                  child: NextPage(),
                ),
              )
            ],
          ),
        ],
      )),
    );
  }

  NextPage() {
    return Container(
      alignment: Alignment.bottomRight,
      height: 75,
      width: 85,
      padding: const EdgeInsets.only(right: 20, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(100),
        ),
      ),
      child: const Icon(
        Icons.arrow_forward,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}
