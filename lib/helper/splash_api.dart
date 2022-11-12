import 'dart:typed_data';
import 'package:http/http.dart' as http;

class SplashHelper {
  SplashHelper._();
  static final SplashHelper splashHelper = SplashHelper._();

  Future<Uint8List?> splashImage() async {
    String uri = "https://source.unsplash.com/random/700×900/?wildAnimal";
    http.Response response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    return null;
  }
}
