import 'package:flutter/material.dart';

import '../common/custom_app_bar.dart';
import '../global/global_data.dart';
import '../helper/db_helpers.dart';
import '../model/model.dart';
import '../style/strings.dart';
import '../style/text_styles.dart';

class ChoosePlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFc19e82),
      body: Stack(
        children: [
          Container(
            color: const Color(0xffC19E82),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Text(
                    Strings.chooseAPlan,
                    style: TextStyles.headingTextStyle,
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: DbHelper.dbHelper
                        .fetchAllRespons(data: Global.wildAnimalSplashData),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        List<WildAnimal>? res = snapShot.data;

                        print("+++++++");
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: Global.wildAnimalSplashData.length,
                            itemBuilder: (context, i) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.5),
                                          BlendMode.srcATop,
                                        ),
                                        child: Image.asset(
                                          "${Global.wildAnimalSplashData[i].image}",
                                          height: height * 0.6 / 4,
                                          width: width,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      bottom: 0,
                                      left: 48,
                                      right: 48,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "${Global.wildAnimalSplashData[i].months}\n subscription",
                                            style: TextStyles
                                                .subscriptionTextStyle,
                                          ),
                                          Spacer(),
                                          Text(
                                            "${Global.wildAnimalSplashData[i].price}",
                                            style: TextStyles
                                                .subscriptionAmountTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else if (snapShot.hasError) {
                        return Center(child: Text("${snapShot.error}"));
                      } else {
                        return Container(
                          color: Colors.red,
                        );
                      }
                    },
                  ),
                ),
                Positioned(
                  bottom: 48,
                  left: 20,
                  child: Text(Strings.LAST_STEP_TO_ENJOY,
                      style: TextStyles.buttonTextStyle),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          Positioned(
            bottom: -30,
            right: -30,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('home_Page');
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFe9d1b5),
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
    );
  }
}
