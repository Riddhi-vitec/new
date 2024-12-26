import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../di/di.dart';
import '../../../imports/common.dart';
import '../bloc/my_products_bloc.dart';
import 'build_product_form.dart';

Widget buildProductGridList(
    {required LocalProductsWithInitialState state,
    required BuildContext context,
    required MyProductsBloc myProductsBloc}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: screenHPadding, vertical: screenVPadding),
    child: GridView.builder(
      itemCount: state.localProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 0.8),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.colorPrimary, width: 1.w),
            borderRadius: BorderRadius.circular(cardRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        myProductsBloc.add(TriggerDeleteLocalProduct(
                            id: state.localProducts[index].id));
                      },
                      child: const Icon(Icons.delete)),
                  InkWell(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext dialogContext) {
                            return BlocBuilder<MyProductsBloc,
                                LocalProductsWithInitialState>(
                              bloc: myProductsBloc..add(TriggerEditOptionEvent(productID: state.localProducts[index].id, name: state.localProducts[index].name, price: state.localProducts[index].price, stock: state.localProducts[index].stock.toString())),
                              builder: (context, state) {
                                return CustomAlertDialog(
                                  title: AppStrings
                                      .myProducts_addUpdateProductForm_title,
                                onTapLeftButton: () {     if (myProductsBloc.formKey.currentState!
                                    .validate()) {
                                  myProductsBloc.add(
                                    TriggerUpdateLocalProduct(
                                      id: state.localProducts[index].id,
                                      name: state
                                          .productNameController.text,
                                      price: state
                                          .productPriceController.text,
                                      stock: state
                                          .productStockController.text,
                                    ),
                                  );
                                }},
                                  leftButtonText:
                                  AppStrings.myProducts_editProductBtn,
                                  rightButtonText:
                                  AppStrings.confirmationDialog_closeBtn,
                                  body: buildProductForm(
                                      context: context,
                                      state: state,
                                      isForEdit: false,
                                      myProductsBloc: myProductsBloc,
                                      onPressed: () {}),
                                );

                              },
                            );
                          },
                        );
                      },
                      child: const Icon(Icons.edit))
                ],
              ),
              if (state.localProducts[index].fileUrl.isEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: SvgPicture.asset(
                    Assets.icLogo,
                    fit: BoxFit.cover,
                    height: 80.h,
                    width: 80.w,
                  ),
                ),
              if (state.localProducts[index].fileUrl.isNotEmpty)
                Image.file(
                  File(state.localProducts[index].fileUrl),
                  fit: BoxFit.cover,
                  height: 80.h,
                  width: 80.w,
                ),
              const Spacer(),
              Center(child: Text(state.localProducts[index].name)),
              const Spacer(),
              Divider(
                color: AppColor.colorPrimary,
              ),
              Text(
                'Price: USD ${state.localProducts[index].price}',
                style: Style.paragraphStyle(),
              ),
              Text('Stock: ${state.localProducts[index].stock}',
                  style: Style.paragraphStyle())
            ],
          ),
        );
      },
    ),
  );
}
