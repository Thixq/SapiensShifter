import 'dart:typed_data';

import 'package:image/image.dart' as img;

Uint8List imageCleanEXIFData({
  required Uint8List photoBytes,
}) {
  final decoded = img.decodeImage(photoBytes);
  if (decoded == null) throw Exception('Resim decode edilemedi');
  final resized = img.copyResize(decoded, width: 1024);
  final result = Uint8List.fromList(img.encodeJpg(resized, quality: 90));
  return result;
}
