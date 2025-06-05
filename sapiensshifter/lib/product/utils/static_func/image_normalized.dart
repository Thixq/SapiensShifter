import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:sapiensshifter/core/logging/custom_logger.dart';

class ImageNormalized {
  static final CustomLogger _logger = CustomLogger('ImageNormalizedLogger');

  static Uint8List imageCleanEXIFData({
    required Uint8List photoBytes,
  }) {
    final decoded = img.decodeImage(photoBytes);
    if (decoded == null) throw Exception('Resim decode edilemedi');
    final resized = img.copyResize(decoded, width: 1024);
    final result = Uint8List.fromList(img.encodeJpg(resized, quality: 90));
    return result;
  }

  static Future<Uint8List?> reshapeImageToAspectRatio({
    required Uint8List imageBytes,
    required double targetAspectRatio,
    img.Color? backgroundColor,
  }) async {
    try {
      final originalImage = img.decodeImage(imageBytes);
      if (originalImage == null) {
        _logger.info('Error: Image could not be decoded.');
        return null;
      }

      if (targetAspectRatio <= 0) {
        _logger.info(
          'Error: Aspect ratio (targetAspectRatio) must be a positive value.',
        );
        return null;
      }

      final originalWidth = originalImage.width;
      final originalHeight = originalImage.height;

      if (originalHeight <= 0 || originalWidth <= 0) {
        _logger.info(
          'Error: Original image dimensions (width and height) are zero or negative.',
        );
        return null;
      }
      final originalAspectRatio = originalWidth / originalHeight;

      int newCanvasWidth;
      int newCanvasHeight;

      if (targetAspectRatio > originalAspectRatio) {
        newCanvasHeight = originalHeight;
        newCanvasWidth = (originalHeight * targetAspectRatio).round();
      } else if (targetAspectRatio < originalAspectRatio) {
        newCanvasWidth = originalWidth;
        newCanvasHeight = (originalWidth / targetAspectRatio).round();
      } else {
        newCanvasWidth = originalWidth;
        newCanvasHeight = originalHeight;
      }
      if (newCanvasWidth <= 0 || newCanvasHeight <= 0) {
        _logger.info(
          'Error: The calculated new canvas dimensions are invalid: ${newCanvasWidth}x$newCanvasHeight',
        );
        return null;
      }

      final newImage =
          img.Image(width: newCanvasWidth, height: newCanvasHeight);

      final bgColor = backgroundColor ?? img.ColorRgba8(0, 0, 0, 0);
      img.fill(newImage, color: bgColor);

      final offsetX = (newCanvasWidth - originalWidth) ~/ 2;
      final offsetY = (newCanvasHeight - originalHeight) ~/ 2;

      img.compositeImage(
        newImage,
        originalImage,
        dstX: offsetX,
        dstY: offsetY,
      );

      final outputBytes = img.encodePng(newImage);
      return outputBytes;
    } catch (e, stacktrace) {
      _logger
        ..info('An error occurred while re-editing the image: $e')
        ..info('Stacktrace: $stacktrace');
      return null;
    }
  }
}
