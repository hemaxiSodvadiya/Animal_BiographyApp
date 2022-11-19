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
            // color: const Color(0xffC19E82),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(),
                SizedBox(height: 20),
                Text(
                  "Choose a plan",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                    child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<DBData>? res = snapshot.data;
                      return ListView.builder(
                        itemBuilder: (context, i) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              image: DecorationImage(
                                image: MemoryImage(res[i].image),
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(
                                    Color(0xffC19E82), BlendMode.modulate),
                              ),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 15),
                                Text(
                                  "${res[i].time}\nSubscription",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white.withOpacity(0.8),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: width / 3,
                                  child: Text(
                                    "\$ ${res[i].price}",
                                    style: TextStyle(
                                      fontSize: 33,
                                      color: Colors.white.withOpacity(0.8),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: res!.length,
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("${snapshot.error}"));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.brown),
                      );
                    }
                  },
                  future: DBHelper.dbHelper.fetchAllRecord(
                      tableName: "splash", data: Global.detailsOfData),
                )),
                SizedBox(height: 20),
                Text(
                  "Last Step to enjoy",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("home_page");
              },
              child: NextPage(),
            ),
          )
        ],
      ),
    );
  }

  NextPage() {
    return Container(
      alignment: Alignment.bottomRight,
      height: 70,
      width: 80,
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
