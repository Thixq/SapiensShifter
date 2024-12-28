import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Image check',
    () async {
      final imageUrl = Uri.parse('https://picsum.photos/200/300.webp');
      final isImage = await isImageFromResponse(imageUrl);
      print(isImage ? 'Bu bir görsel.' : 'Bu bir görsel değil.');
      expect(isImage, true);
    },
  );
}

Future<bool> isImageFromResponse(Uri url) async {
  try {
    // İlk birkaç baytı almak için bir HTTP GET isteği yapıyoruz.
    final request = await HttpClient().getUrl(url);
    final response = await request.close();

    if (response.statusCode == 200) {
      // İlk birkaç baytı okuyoruz.
      final firstBytes = await response.fold<List<int>>(
        [],
        (buffer, data) => buffer..addAll(data.take(8)),
      );

      if (firstBytes.isNotEmpty) {
        // Magic bytes ile kontrol.
        final magicBytes = firstBytes.sublist(0, 4);
        print(magicBytes);
        // Magic bytes eşleşmeleri
        return _isMagicBytesMatch(magicBytes);
      }
    }
    return false;
  } catch (e) {
    print('Error: $e');
    return false;
  }
}

bool _isMagicBytesMatch(List<int> magicBytes) {
  // Magic bytes eşleşmelerini kontrol eden yöntem.
  const jpegSignature = [0xFF, 0xD8];
  const pngSignature = [0x89, 0x50, 0x4E, 0x47];
  const gif87aSignature = [0x47, 0x49, 0x46, 0x38, 0x37, 0x61];
  const gif89aSignature = [0x47, 0x49, 0x46, 0x38, 0x39, 0x61];
  const webpSignature = [0x52, 0x49, 0x46, 0x46]; // RIFF
  const webpFormat = [0x57, 0x45, 0x42, 0x50]; // WEBP

  if (magicBytes.startsWith(jpegSignature)) return true;
  if (magicBytes.startsWith(pngSignature)) return true;
  if (magicBytes.startsWith(gif87aSignature)) return true;
  if (magicBytes.startsWith(gif89aSignature)) return true;

  // WebP kontrolü: İlk 4 bayt RIFF, ardından 8-12. baytlar WEBP olmalı.
  if (magicBytes.startsWith(webpSignature) &&
      magicBytes.sublist(8, 12).startsWith(webpFormat)) {
    return true;
  }

  return false;
}

extension ListStartsWith<T> on List<T> {
  bool startsWith(List<T> other) {
    if (length < other.length) return false;
    for (var i = 0; i < other.length; i++) {
      if (this[i] != other[i]) return false;
    }
    return true;
  }
}
