import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../imports/common.dart';
import '../../../di/di.dart';

import '../bloc/contact_us_bloc.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final ContactUsBloc _contactUsBloc = instance<ContactUsBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactUsBloc, ContactUsWithInitialState>(
      bloc: _contactUsBloc,
      listener: (context, state) {
        if (state.message.isNotEmpty) {
          Navigator.pop(context);
          Toast.nullableIconToast(
              message: state.message,
              isErrorBooleanOrNull: state.isFailure ? true : false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
              centerTitle: false,
              title: AppStrings.myAccount_profileSettings_contactUsView_screen_title,
              onTap: () {
                _contactUsBloc.add(TriggerContactUsPageRefresh());
                Navigator.pop(context);
              }),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              padding:
                  EdgeInsets.only(left: screenHPadding, right: screenVPadding),
              child: Form(
                key: _contactUsBloc.formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.only(bottom: widgetBottomPadding),
                      child: RowWithTwoTextFields(
                        isLeftFieldHasError: state.isFirstNameInvalid,
                        leftFieldFocusNode: state.firsNameFocusNode,
                        leftLabel: AppStrings.textfield_addFirstName_text,
                        leftTextFieldEditController: state.firstNameController,
                        leftTextFieldHintText: AppStrings.textfield_addFirstName_hint,
                        leftTextFieldVariant: TextFieldVariant.user,
                        onTapLeft: () {
                          _contactUsBloc.add(
                              const TriggerRequestFocusForTextFieldWithChar(
                                  isPhone: null, hasFocus: false));
                        },
                        leftTextFieldValidator: (value) {
                          _contactUsBloc.add(TriggerContactUsFirstNameCheck(
                              firstName: state.firstNameController.text));
                          return validateFirstName(value!);
                        },
                        isRightTextFieldHasError: state.isLastNameInvalid,
                        rightTextFieldFocusNode: state.lastNameFocusNode,
                        rightTextFieldEditController: state.lastNameController,
                        rightLabel: AppStrings.textfield_addLastName_text,
                        rightTextFieldHintText: AppStrings.textfield_addLastName_hint,
                        rightTextFieldVariant: TextFieldVariant.user,
                        onTapRight: () {
                          _contactUsBloc.add(
                              const TriggerRequestFocusForTextFieldWithChar(
                                  isPhone: null, hasFocus: false));
                        },
                        rightTextFieldValidator: (value) {
                          _contactUsBloc.add(TriggerContactUsLastNameCheck(
                              lastName: state.lastNameController.text));
                          return validateLastName(value!);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: widgetBottomPadding),
                      child: CustomPhoneField(
                        mobileController: state.mobileNumberController,
                        mobileFocusNode: state.mobileNumberFocusNode,
                        hasFocus: state.hasFocusMobileNumberField,
                        hasError: state.isMobileNumberInvalid,
                        label: AppStrings.textfield_addMobileNo_text,
                        hint: AppStrings.textfield_addMobileNo_hint,
                        errorMessage: state.invalidMobileNumberError,
                        onTap: () {
                          _contactUsBloc.add(
                              const TriggerRequestFocusForTextFieldWithChar(
                                  isPhone: true, hasFocus: true));
                        },
                        onChanged: (value) {
                          _contactUsBloc.add(
                            TriggerOnChangeContactUs(
                                mobileNumber: value!.completeNumber,
                                code: value.countryISOCode),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: widgetBottomPadding),
                      child: CustomTextField(
                        isError: state.isEmailInvalid,
                        focusNode: state.emailFocusNode,
                        controller: state.emailController,
                        label: AppStrings.textfield_addEmail_text,
                        hintText: AppStrings.textfield_addEmail_hint,
                        variant: TextFieldVariant.email,
                        onTap: () {
                          _contactUsBloc.add(
                              const TriggerRequestFocusForTextFieldWithChar(
                                  isPhone: null, hasFocus: false));
                        },
                        validator: (value) {
                          _contactUsBloc.add(TriggerContactUsEmailCheck(
                              email: state.emailController.text));
                          return validateEmail(value!);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: widgetBottomPadding),
                      child: TextFieldWithCharCounter(
                        isError: state.isMessageInvalid,
                        focusNode: state.messageFocusNode,
                        hasFocus: state.hasFocusMessageField,
                        controller: state.messageController,
                       label: AppStrings.textfield_addMessage_text,
                        hintText: AppStrings.textfield_addMessage_hint,
                        textInputAction: TextInputAction.done,
                        error: state.invalidMessageError,
                        onTap: () {
                          _contactUsBloc.add(
                            const TriggerRequestFocusForTextFieldWithChar(
                              isPhone: false,
                              hasFocus: true,
                            ),
                          );
                        },
                        validator: (value) {
                          _contactUsBloc.add(TriggerContactUsMessageCheck(
                              message: state.messageController.text));
                        },
                      ),
                    ),
                    CustomButton(
                      onTap: () {

                          _contactUsBloc.add(
                            TriggerContactUsMobileNumberCheck(
                              isEmailValid: state.isEmailInvalid,
                                isFirstNameValid: state.isFirstNameInvalid,
                                isLastNameValid: state.isLastNameInvalid,
                                isMessageValid: state.isMessageInvalid,
                                mobileNumber: state.mobileNumberController.text,
                                minLength: state.minLength,
                              code: state.code,
                              email: state.emailController.text,
                              lastName: state.lastNameController.text,
                              message: state.messageController.text,
                              firstName: state.firstNameController.text
                            ),
                          );


                      },
                      text: AppStrings.common_submitBtn,
                      variant: ButtonVariant.btnPrimary,
                      buttonSize: ButtonSize.large,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


