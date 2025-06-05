import 'package:flutter_test/flutter_test.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';

void main() {
  group('mime type', () {
    test('mimeTpye image test', () {
      const imaheJpg = 'https://example.com/image.jpg';
      const imaheJpeg = 'https://example.com/image.jpeg';
      const imaheHeic = 'https://example.com/image.heic';
      final mimeJpg = imaheJpg.sapiExt.imageMimeType;
      final mimeJpeg = imaheJpeg.sapiExt.imageMimeType;
      final mimeHeic = imaheHeic.sapiExt.imageMimeType;

      expect(mimeJpg, 'image/jpg');
      expect(mimeJpeg, 'image/jpeg');
      expect(mimeHeic, 'image/heic');
    });

    test('mimeTpye image null test', () {
      const imaheNull = 'https://example.com/image.gif';
      final mimeNull = imaheNull.sapiExt.imageMimeType;

      expect(mimeNull, null);
    });
    test('mimeTpye image empty test', () {
      const imaheEmpty = '';
      final mimeEmpty = imaheEmpty.sapiExt.imageMimeType;

      expect(mimeEmpty, null);
    });
    test('mimeTpye image null value test', () {
      const String? imaheNull = null;
      final mimeNull = imaheNull.sapiExt.imageMimeType;
      expect(mimeNull, null);
    });
  });
}
