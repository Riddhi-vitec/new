import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/paddings.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/widgets/custom_app_bar.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/language_and_currency/bloc/global_settings_bloc.dart';

import '../../../di/di.dart';
import '../../../imports/common.dart';

class LanguageAndCurrencyView extends StatefulWidget {
  const LanguageAndCurrencyView({super.key});

  @override
  State<LanguageAndCurrencyView> createState() =>
      _LanguageAndCurrencyViewState();
}

class _LanguageAndCurrencyViewState extends State<LanguageAndCurrencyView> {
  late GlobalSettingsBloc _languageAndCurrencyBloc;

  @override
  void initState() {

    _languageAndCurrencyBloc = instance<GlobalSettingsBloc>();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalSettingsBloc,
        GlobalSettingsWithInitialState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(
              title: AppStrings.myAccount_languageCurrency_screen_title,
              centerTitle: false),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenHPadding, vertical: screenVPadding),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: widgetBottomPadding),
                  child: Text(
                    AppStrings
                        .myAccount_languageCurrency_selectCurrency_title,
                    style: Style.appBarTitleStyle(
                        color: AppColor.colorPrimaryText),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showCurrencyPicker(
                      context: context,
                      showFlag: true,
                      theme: CurrencyPickerThemeData(
                          currencySignTextStyle: Style.subTitleStyle(
                              color: AppColor.colorPrimaryText),
                          titleTextStyle: Style.subTitleBoldStyle(
                              color: AppColor.colorPrimaryText),
                          subtitleTextStyle: Style.paragraphStyle(
                              color: AppColor.colorSecondaryText)),
                      showCurrencyName: true,
                      showCurrencyCode: true,
                      onSelect: (Currency currency) {
                        _languageAndCurrencyBloc.add(TriggerChangeCurrency(currency: currency));
                      },
                      currencyFilter: <String>[
                        'EUR',
                        'GBP',
                        'USD',
                        'INR',
                        'YEN'
                      ],
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: widgetBottomPadding),
                    child: Card(
                      elevation: cardElevation,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(cardRadius),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              CurrencyUtils.currencyToEmoji(
                                  state.selectedCurrency!),
                              style: Style.subTitleBoldStyle(),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                state.selectedCurrency!.code,
                                style: Style.subTitleStyle(),
                              ),
                            ),
                            Text(
                              state.selectedCurrency!.symbol,
                              style: Style.subTitleStyle(),
                            ),
                            const SizedBox(width: 8.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: widgetBottomPadding),
                  child: Text(
                    AppStrings
                        .myAccount_languageCurrency_selectLanguage_title,
                    style: Style.appBarTitleStyle(
                        color: AppColor.colorPrimaryText),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        shape: Style.bottomSheetShape(),
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenHPadding,
                                vertical: screenVPadding),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0),
                                  child: Text(
                                      AppStrings
                                          .myAccount_languageCurrency_selectLanguage_title,
                                      style: Style.titleStyle()),
                                ),
                                ListView.builder(
                                  itemCount:
                                      generateSupportedLocales().length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        _languageAndCurrencyBloc.add(
                                            TriggerChangeLanguage(
                                                languageCode:
                                                    LanguageCode.values[index]));
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          child: Text(
                                            LanguageCode
                                                .values[index].languageName,
                                            style: Style.paragraphStyle(
                                                color: AppColor.colorAccent),
                                          )),
                                    );
                                  },
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Card(
                    elevation: cardElevation,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(cardRadius),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(state.selectedLanguage,
                              style: Style.subTitleStyle()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
