import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';
import '../../../imports/common.dart';
import '../bloc/my_products_bloc.dart';
import '../widgets/build_product_form.dart';
import '../widgets/build_product_gridlist.dart';

class MyProductsView extends StatefulWidget {
  const MyProductsView({super.key});

  @override
  State<MyProductsView> createState() => _MyProductsViewState();
}

class _MyProductsViewState extends State<MyProductsView> {
  MyProductsBloc myProductsBloc = instance<MyProductsBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          myProductsBloc..add(const TriggerFetchLocalProducts()),
      child: BlocListener<MyProductsBloc, LocalProductsWithInitialState>(
        listener: (context, state) {
          if (state.message.isNotEmpty) {
            Toast.nullableIconToast(
              message: state.message,
              isErrorBooleanOrNull: state.isFailure ? true : false,
            );
          }
        },
        child: BlocBuilder<MyProductsBloc, LocalProductsWithInitialState>(
          builder: (context, state) {
            return Scaffold(
                appBar: const CustomAppBar(
                  title: AppStrings.myProducts_screen_title,
                  isLeading: false,
                  centerTitle: false,
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        // CustomAlertDialog(title: 'Hello', onTapYes: (){},subTitle: 'World',);
                        return BlocBuilder<MyProductsBloc,
                            LocalProductsWithInitialState>(
                          bloc: myProductsBloc..add(TriggerCreateOptionEvent()),
                          builder: (context, state) {
                            return CustomAlertDialog(
                              title: AppStrings
                                  .myProducts_addUpdateProductForm_title,
                              onTapLeftButton: () {
                                if (myProductsBloc.formKey.currentState!
                                    .validate()) {
                                  myProductsBloc.add(TriggerAddLocalProduct(
                                      name: state.productNameController.text,
                                      price: state.productPriceController.text,
                                      stock:
                                          state.productStockController.text));
                                }
                              },
                              leftButtonText:
                                  AppStrings.myProducts_addProductBtn,
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
                  child: const Icon(Icons.add),
                ),
                body: state.isLoading
                    ? CustomLoader(
                        child: buildProductGridList(
                            state: state,
                            context: context,
                            myProductsBloc: myProductsBloc),
                      )
                    : buildProductGridList(
                        state: state,
                        context: context,
                        myProductsBloc: myProductsBloc));
          },
        ),
      ),
    );
  }
}
