import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickdrop_sellers/src/domain/entity/new_product_entity.dart';
import 'package:quickdrop_sellers/src/domain/usecase/new_product_usecase.dart';

part 'newproduct_state.dart';

class NewProductCubit extends Cubit<NewProductState> {
  NewProductCubit({
    required NewProductUsecase usecase,
  })  : _usecase = usecase,
        super(NewProductState());
  final NewProductUsecase _usecase;
  final ImagePicker _imagePicker = ImagePicker();

  void setProductName(String value) {
    emit(
      state.copyWith(
        newProduct: state.newProduct.copyWith(
          name: value,
        ),
      ),
    );
  }

  void setPrice(int value) {
    emit(
      state.copyWith(
        newProduct: state.newProduct.copyWith(
          price: value,
        ),
      ),
    );
  }

  void setDescription(String value) {
    emit(
      state.copyWith(
        newProduct: state.newProduct.copyWith(
          description: value,
        ),
      ),
    );
  }

  void addTag(String value) {
    List<String> currentTags = _getListTags();
    currentTags.add(value);
    emit(
      state.copyWith(
        newProduct: state.newProduct.copyWith(
          tags: currentTags,
        ),
      ),
    );
  }

  void removeTag({required int index}) {
    List<String> currentTags = _getListTags();
    currentTags.removeAt(index);
    emit(
      state.copyWith(
        newProduct: state.newProduct.copyWith(
          tags: currentTags,
        ),
      ),
    );
  }

  Future<void> saveNewProduct() async {
    emit(
      state.copyWith(
        status: NewProductStatus.loading,
        message: '',
      ),
    );
    try {
      final NewProductStatus response = await _usecase.saveNewProduct(
        product: state.newProduct,
      );
      emit(
        state.copyWith(
          status: response,
          message: 'producto registrado correctamente',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NewProductStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> selectImages() async {
    emit(
      state.copyWith(
        status: NewProductStatus.initial,
      ),
    );
    try {
      List<XFile> currentImages = _getListImages();
      final List<XFile> response = await _imagePicker.pickMultiImage(
        requestFullMetadata: true,
        limit: 8,
      );
      if (response.isNotEmpty) {
        currentImages.addAll(response);
        emit(
          state.copyWith(
            newProduct: state.newProduct.copyWith(
              images: currentImages,
            ),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
        ),
      );
    }
  }

  void deleteImage({required int index}) {
    final List<XFile> images = _getListImages();
    images.removeAt(index);
    emit(
      state.copyWith(
        newProduct: state.newProduct.copyWith(
          images: images,
        ),
      ),
    );
  }

  List<XFile> _getListImages() {
    return List<XFile>.from(
      state.newProduct.images,
    );
  }

  List<String> _getListTags() {
    return List<String>.from(
      state.newProduct.tags,
    );
  }
}
