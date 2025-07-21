part of '../new_product_add_view.dart';

class ProductImage extends StatefulWidget {
  const ProductImage({
    required this.onTap,
    super.key,
  });

  final void Function(File? imageFile) onTap;

  @override
  State<ProductImage> createState() => ProductImageState();
}

class ProductImageState extends State<ProductImage> {
  Uint8List? image;

  void resetImage() {
    image = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      borderRadius: BorderRadius.circular(context.sized.normalValue),
      child: Container(
        width: 35.w,
        padding: const EdgeInsets.all(8),
        decoration: ShapeDecoration(
          shape: DashedRoundedShapeBorder(
            dashLength: 9,
            gapLength: 4,
            side: const BorderSide(
              strokeAlign: BorderSide.strokeAlignCenter,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(context.sized.normalValue),
          ),
        ),
        child: AspectRatio(
          aspectRatio: 1 / 1.3,
          child: image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(context.sized.lowValue),
                  child: Image.memory(
                    image!,
                    fit: BoxFit.fitHeight,
                  ),
                )
              : const SvgAssetBuilder(
                  svgPath: AssetsPathConstant.productPlaceHolder,
                ),
        ),
      ),
    );
  }

  Future<void> _onTap() async {
    File? imageFile;
    final imageXFile = await ImagePickerService().pick(PickerSource.gallery);
    if (imageXFile?.path != null) {
      imageFile = File(imageXFile!.path);
      final imageByte = await imageFile.readAsBytes();
      final imageCleaned =
          ImageNormalized.imageCleanEXIFData(photoBytes: imageByte);
      image = imageCleaned;
    }
    widget.onTap(imageFile);
    setState(() {});
  }
}
