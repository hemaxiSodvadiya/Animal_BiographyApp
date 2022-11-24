import 'dart:math';

import 'package:flutter/material.dart';

import '../common/custom_app_bar.dart';
import '../global/global_data.dart';
import '../helper/db_helpers.dart';
import '../model/model.dart';
import '../style/strings.dart';
import '../style/text_styles.dart';
import 'choose_plan_screen.dart';

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
    Future<List<DBChooseAnimalData>> details = DBHelper.dbHelper
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
                    DBChooseAnimalData randomImage = res[randomIndex];

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
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.brown.shade200,
                      ),
                    );
                  }
                },
              ),
              Column(
                children: <Widget>[
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
                            text: Strings.READY_TO_WATCH,
                            style: TextStyles.bigHeadingTextStyle,
                          ),
                          TextSpan(text: "\n"),
                          TextSpan(
                            text: Strings.READY_TO_WATCH_DESC,
                            style: TextStyles.bodyTextStyle,
                          ),
                          TextSpan(text: "\n"),
                          TextSpan(text: "\n"),
                          TextSpan(
                            text: Strings.START_ENJOYING,
                            style: TextStyles.buttonTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: -30,
                right: -30,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChoosePlanScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFDAD4CC).withOpacity(0.8),
                    ),
                    child: Align(
                      alignment: Alignment(-0.4, -0.4),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }

