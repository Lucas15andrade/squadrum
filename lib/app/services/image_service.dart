import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  static Future<File> comprimirImagem(File file) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path + ".jpg";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      tempPath,
      quality: 50,
    );
    return result;
  }
}
