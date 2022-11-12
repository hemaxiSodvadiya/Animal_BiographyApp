import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../common/custom_app_bar.dart';
import '../style/strings.dart';
import '../style/text_styles.dart';
import 'choose_plan_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future splashImage() async {
    String uri = "https://source.unsplash.com/random/700×900/?wildAnimal";
    http.Response response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    return null;
  }

  int live = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashImage();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: IndexedStack(
        index: live,
        children: [
          // Splash Screen 1
          Stack(
            children: [
              FutureBuilder(
                future: splashImage(),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    return Image.memory(
                      snapShot.data,
                      height: _height,
                      width: _width,
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.modulate,
                      color: const Color(0xffC19E82),
                    );
                  } else if (snapShot.hasError) {
                    return Center(
                      child: Text("${snapShot.error}"),
                    );
                  } else {
                    return CircularProgressIndicator();
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
          // Splash Screen 2
        ],
      ),
    );
  }
}
