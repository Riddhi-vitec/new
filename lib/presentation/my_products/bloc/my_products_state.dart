part of 'my_products_bloc.dart';


@freezed
class LocalProductsWithInitialState with _$LocalProductsWithInitialState {
  const factory LocalProductsWithInitialState({
    required String message, imageFilePath,
    required TextEditingController productNameController, productPriceController, productStockController,
    required FocusNode productNameFocusNode, productPriceFocusNode, productStockFocusNode,
    required bool isProductNameInvalid, isProductPriceInvalid, isProductStockInvalid, hasError, hasImageLoaded, isLoading, isFailure,
    required List<LocalProducts> localProducts,
  }) = _LocalProductsWithInitialState;

  factory LocalProductsWithInitialState.initial() =>
      LocalProductsWithInitialState(
        message: '',
        imageFilePath: '',
        isFailure: false,
        hasImageLoaded: false,
        productNameController: TextEditingController(),
        productPriceController: TextEditingController(),
        productStockController: TextEditingController(),
        productNameFocusNode: FocusNode(),
        productPriceFocusNode: FocusNode(),
        productStockFocusNode: FocusNode(),
        isProductNameInvalid: false,
        isProductPriceInvalid: false,
        isProductStockInvalid: false,
        hasError: false,
        isLoading: false,
        localProducts: [],
      );
}
