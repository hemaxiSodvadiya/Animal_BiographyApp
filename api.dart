import 'dart:typed_data';

import 'package:http/http.dart' as http;

class ImageApi {
  ImageApi._();
  static ImageApi imageApi = ImageApi._();

  Future<Uint8List?> getImage({required String search}) async {
    http.Response image = await http
        .get(Uri.parse("https://source.unsplash.com/random/?wildanimal"));

    if (image.statusCode == 200) {
      return image.bodyBytes;
    } else {
      null;
    }
  }
}
