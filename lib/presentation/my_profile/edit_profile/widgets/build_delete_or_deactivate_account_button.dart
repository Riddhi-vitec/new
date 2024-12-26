import 'package:flutter/cupertino.dart';

import '../../../../imports/common.dart';

Padding buildDeleteOrDeactivateAccountButton(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: widgetBottomPadding),
    child: CustomButton(
      text: AppStrings
          .myAccount_profileSettings_editView_deleteAccountBtn,
      buttonSize: ButtonSize.medium,
      variant: ButtonVariant.btnWithBorder,
      onTap: () {
        Navigator.pushNamed(
            context, RouteName.routeDeactivateAccount);
      },
    ),
  );
}