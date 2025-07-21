import 'dart:io';

import 'package:core/core.dart';
import 'package:sapiensshifter/core/constant/query_path_constant.dart';
import 'package:sapiensshifter/core/constant/storage_path_constant.dart';
import 'package:sapiensshifter/core/exception/handler/custom_handler/serivce_error_handler.dart';
import 'package:sapiensshifter/core/exception/utils/error_util.dart';
import 'package:sapiensshifter/core/state/base/base_cubit.dart';
import 'package:sapiensshifter/feature/new_product_add/view_model/state/new_product_state.dart';
import 'package:sapiensshifter/product/models/categories_model/categories_model.dart';
import 'package:sapiensshifter/product/models/extras_model/extras_model.dart';
import 'package:sapiensshifter/product/models/product_model/product_model.dart';
import 'package:sapiensshifter/product/utils/export_dependency_package/export_package.dart';
import 'package:sapiensshifter/product/utils/static_func/image_normalized.dart';
import 'package:uuid/v7.dart';

class NewProductViewModel extends BaseCubit<NewProductState> {
  NewProductViewModel(
    super.initialState, {
    required INetworkManager networkManager,
    required IStorageManager storageManager,
  })  : _networkManager = networkManager,
        _storageManager = storageManager;

  final INetworkManager _networkManager;
  final IStorageManager _storageManager;

  Future<void> _uploadImageStorage() async {
    await ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        if (state.product.imagePath != null) {
          final mimeType = state.product.imagePath?.sapiExt.imageMimeType;
          final mimeSuffix = mimeType?.split('/').last ?? 'jpg';
          final path =
              '${StoragePathConstant.productImageBasePath}/${state.product.id}/${const UuidV7().generate()}.$mimeSuffix';
          final imageFile = File(state.product.imagePath!);
          final imageByte = await imageFile.readAsBytes();
          final cleanByte =
              ImageNormalized.imageCleanEXIFData(photoBytes: imageByte);
          final url = await _storageManager.storageOperation
              .upload(path: path, byteFile: cleanByte, mimeType: mimeType);
          emit(state.copyWith(product: state.product.copyWith(imagePath: url)));
        }
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async {},
    );
  }

  void productEdit({required ProductModel product}) {
    emit(state.copyWith(product: product));
  }

  void resetProduct() {
    emit(
      state.copyWith(
        product: ProductModel(
          id: const UuidV7().generate(),
          category: state.product.category,
          productOptions: state.product.productOptions,
        ),
      ),
    );
  }

  Future<void> getCategory() async {
    const path = QueryPathConstant.categoryColPath;

    final result = await _getItems(path: path, model: const CategoriesModel());
    final allWithoutList = result
        .where(
          (element) => element.id != StringConstant.allCategoryId,
        )
        .toList();

    emit(state.copyWith(category: allWithoutList));
  }

  Future<void> getExtras() async {
    const path = QueryPathConstant.extras;

    final result = await _getItems(path: path, model: const ExtrasModel());

    emit(state.copyWith(extras: result));
  }

  Future<void> getOptions() async {
    await getCategory();
    await getExtras();
  }

  Future<List<T>> _getItems<T extends IBaseModel<T>>({
    required String path,
    required T model,
  }) async {
    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        final result = await _networkManager.networkOperation
            .getItemsQuery<T>(path: path, model: model);
        return result;
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async => [],
    );
  }

  Future<bool> uploadProduct() async {
    final path = '${QueryPathConstant.productsColPath}/${state.product.id}';

    return ErrorUtil.runWithErrorHandlingAsync(
      action: () async {
        await _uploadImageStorage();
        return _networkManager.networkOperation
            .addItem(path: path, item: state.product);
      },
      errorHandler: ServiceErrorHandler(),
      fallbackValue: () async => false,
    );
  }
}
