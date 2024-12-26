import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../imports/common.dart';
import '../bloc/my_products_bloc.dart';

Form buildProductForm(
    {required BuildContext context,
    required LocalProductsWithInitialState state,
    required MyProductsBloc myProductsBloc,
      required bool isForEdit,
    required VoidCallback onPressed}) {
  return Form(
    key: myProductsBloc.formKey,
    child: Center(
      child: SizedBox(


        width: MediaQuery.of(context).size.width * 0.8,
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: widgetBottomPadding),
              child: CustomButton(
                variant: ButtonVariant.btnPrimary,
                onTap: () {
                  myProductsBloc.add(const TriggerChooseImageFromGallery());
                },
                text: AppStrings
                    .myProducts_addUpdateProductForm_chooseFromGalleryBtn,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: widgetBottomPadding),
              child: CustomTextField(
                label: AppStrings.textfield_addProductName_text,
                isError: state.isProductNameInvalid,
                focusNode: state.productNameFocusNode,
                validator: (value) {
                  myProductsBloc.add(TriggerFieldValidation(
                      fieldInput: value!, fieldNumber: 1));
                  return validateProduct(value: value, length: 12);
                },
                controller: state.productNameController,
                hintText: AppStrings.textfield_addProductName_hint,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: widgetBottomPadding),
              child: CustomTextField(
                label: AppStrings.textfield_addProductPrice_text,
                isError: state.isProductPriceInvalid,
                inputFormatters: setRealNumFormat(),
                textInputType: TextInputType.number,
                focusNode: state.productPriceFocusNode,
                controller: state.productPriceController,
                validator: (value) {
                  myProductsBloc.add(TriggerFieldValidation(
                      fieldInput: value!, fieldNumber: 2));
                  return validateProduct(value: value, length: 8);
                },
                hintText: AppStrings.textfield_addProductPrice_hint,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: widgetBottomPadding),
              child: CustomTextField(
                label: AppStrings.textfield_addProductStock_text,
                inputFormatters: setIntegerFormat(),
                textInputType: TextInputType.number,
                isError: state.isProductStockInvalid,
                focusNode: state.productStockFocusNode,
                controller: state.productStockController,
                validator: (value) {
                  myProductsBloc.add(TriggerFieldValidation(
                      fieldInput: value!, fieldNumber: 3));
                  return validateProduct(value: value, length: 8);
                },
                hintText: AppStrings.textfield_addProductStock_hint,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
