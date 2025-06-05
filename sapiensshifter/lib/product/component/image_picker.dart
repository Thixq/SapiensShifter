import 'package:image_picker/image_picker.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/product/interface/utils_interface/image_picker_interface.dart';
import 'package:sapiensshifter/product/utils/enums/picker_source.dart';

class ImagePickerService implements IPicker<XFile> {
  ImagePickerService([ImagePicker? picker]) : _picker = picker ?? ImagePicker();
  final ImagePicker _picker;

  @override
  Future<XFile?> pick(PickerSource source) async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        return _picker.pickImage(
          source: source == PickerSource.camera
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1024,
          maxHeight: 1024,
          imageQuality: 85,
          requestFullMetadata: false,
        );
      },
      fallbackValue: () => null,
    );
  }
}
