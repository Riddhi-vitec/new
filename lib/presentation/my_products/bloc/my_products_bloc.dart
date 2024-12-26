import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:template_flutter_mvvm_repo_bloc/root_app.dart';

import '../../../di/di.dart';
import '../../../imports/common.dart';
import '../../../imports/data.dart';

part 'my_products_event.dart';

part 'my_products_state.dart';

part 'my_products_bloc.freezed.dart';

class MyProductsBloc
    extends Bloc<MyProductsEvent, LocalProductsWithInitialState> {


  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  XFile? image;
  File? imageFile;

  MyProductsBloc() : super(LocalProductsWithInitialState.initial()) {
    on<TriggerFetchLocalProducts>(_onTriggerFetchLocalProducts);
    on<TriggerCreateOptionEvent>(_onTriggerCreateOptionEvent);
    on<TriggerEditOptionEvent>(_onTriggerEditOptionEvent);
    on<TriggerAddLocalProduct>(_onTriggerAddLocalProduct);
    on<TriggerUpdateLocalProduct>(_onTriggerUpdateLocalProduct);
    on<TriggerDeleteLocalProduct>(_onTriggerDeleteLocalProduct);
    on<TriggerFieldValidation>(_onTriggerFieldValidation);
    on<TriggerChooseImageFromGallery>(_onTriggerChooseImageFromGallery);
  }

  FutureOr<void> _onTriggerFetchLocalProducts(TriggerFetchLocalProducts event,
      Emitter<LocalProductsWithInitialState> emit) async {
    emit(state.copyWith(isLoading: true));
    List<LocalProducts> localProducts = await LocalProductsRepository.fetchProducts();
    emit(state.copyWith(
        isLoading: false, localProducts: localProducts));
  }

  FutureOr<void> _onTriggerAddLocalProduct(TriggerAddLocalProduct event,
      Emitter<LocalProductsWithInitialState> emit) async {

    emit(state.copyWith(isLoading: true, message: '',
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
      hasError: false, ));

  List<LocalProducts> products = await LocalProductsRepository.addLocalProduct(
        name: event.name,
        price: event.price.isNotEmpty
            ? double.parse(event.price).toStringAsFixed(2)
            : '',
        stock: event.stock.isNotEmpty ? int.parse(event.stock) : 0,
        fileUrl: imageFile == null ? '' : imageFile!.path);
    emit(state.copyWith(
        isLoading: false, localProducts: products));
    Navigator.pop(navigatorKey.currentContext!);
  }

  FutureOr<void> _onTriggerUpdateLocalProduct(TriggerUpdateLocalProduct event,
      Emitter<LocalProductsWithInitialState> emit) async {
    emit(state.copyWith(isLoading: true));
    List<LocalProducts> products = await LocalProductsRepository.updateLocalProducts(productID: event.id, name: event.name, price: event.price!.isNotEmpty
        ? double.parse(event.price!).toStringAsFixed(2)
        : null, fileUrl: imageFile == null ? '' : imageFile!.path, stock: event.stock!.isNotEmpty ? int.parse(event.stock!) : null,);
    emit(state.copyWith(
        isLoading: false, localProducts:products));
    Navigator.pop(navigatorKey.currentContext!);
  }

  FutureOr<void> _onTriggerDeleteLocalProduct(TriggerDeleteLocalProduct event,
      Emitter<LocalProductsWithInitialState> emit) async {
    emit(state.copyWith(isLoading: true));
    List<LocalProducts> products = await LocalProductsRepository.deleteLocalProduct(productID: event.id);
    emit(state.copyWith(isLoading: false, localProducts:products));
  }

  FutureOr<void> _onTriggerFieldValidation(TriggerFieldValidation event,
      Emitter<LocalProductsWithInitialState> emit) {
    emit(state.copyWith(isLoading: true));

    String filePath = imageFile == null ? '' : imageFile!.path;
    String? validationResultOfName,
        validationResultOfPrice,
        validationResultOfStock;
    if (event.fieldNumber == 1) {
      validationResultOfName =
          validateProduct(value: event.fieldInput, length: 12);
      emit(state.copyWith(
        isProductNameInvalid: validationResultOfName == null ? false : true,
      ));
    }
    if (event.fieldNumber == 2) {
      validationResultOfPrice =
          validateProduct(value: event.fieldInput, length: 8);
      emit(state.copyWith(
        isProductPriceInvalid: validationResultOfPrice == null ? false : true,
      ));
    }
    if (event.fieldNumber == 3) {
      validationResultOfStock =
          validateProduct(value: event.fieldInput, length: 8);
      emit(state.copyWith(
        isProductStockInvalid: validationResultOfStock == null ? false : true,
      ));
    }
    emit(state.copyWith(
      imageFilePath: filePath,
      hasError: validationResultOfName != null ||
          validationResultOfPrice != null ||
          validationResultOfStock != null,
      isLoading: false,
    ));
  }

  FutureOr<void> _onTriggerChooseImageFromGallery(
      TriggerChooseImageFromGallery event,
      Emitter<LocalProductsWithInitialState> emit) async {
    image = await getImage(isFromCamera: false);

    if (image != null) {
      imageFile = File(image!.path);
      emit(state.copyWith(
          hasImageLoaded: true,
          message: AppStrings.myProducts_uploadImageSuccessfully_text,
          isFailure: false));
    }
  }

  FutureOr<void> _onTriggerEditOptionEvent(TriggerEditOptionEvent event, Emitter<LocalProductsWithInitialState> emit) {
   emit(state.copyWith(isLoading: true));
   emit(state.copyWith(isLoading: false,
     productNameController: TextEditingController(text: event.name),
     productPriceController: TextEditingController(text: event.price),
     productStockController: TextEditingController(text: event.stock),
     productNameFocusNode: FocusNode(),
     productPriceFocusNode: FocusNode(),
     productStockFocusNode: FocusNode(),
     isProductNameInvalid: false,
     isProductPriceInvalid: false,
     isProductStockInvalid: false,
     hasError: false,
   ));
  }

  FutureOr<void> _onTriggerCreateOptionEvent(TriggerCreateOptionEvent event, Emitter<LocalProductsWithInitialState> emit) {
  emit(state.copyWith(isLoading: true));
  imageFile = null;
  emit(state.copyWith(isLoading: false,
    imageFilePath: '',
    hasImageLoaded: false,
    message: '',
    isFailure: false,
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
  ));
  }
}
