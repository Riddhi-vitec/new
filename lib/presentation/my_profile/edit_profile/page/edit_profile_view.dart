import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../di/di.dart';
import '../../../../imports/common.dart';
import '../bloc/edit_profile_bloc.dart';
import '../widgets/build_address_field.dart';
import '../widgets/build_birthday_field.dart';
import '../widgets/build_change_EMail_section.dart';
import '../widgets/build_delete_or_deactivate_account_button.dart';
import '../widgets/build_mobile_number_field.dart';
import '../widgets/build_name_section.dart';
import '../widgets/build_profile_image.dart';
import '../widgets/build_update_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({
    super.key,
  });

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  EditProfileBloc editProfileBloc = instance<EditProfileBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => editProfileBloc..add(TriggerFillUpFieldsEvent()),
      child: BlocListener<EditProfileBloc, EditProfileWithInitialState>(
        listener: (context, state) {
          if (state.message.isNotEmpty) {
            Toast.nullableIconToast(
                message: state.message,
                isErrorBooleanOrNull: state.isFailure ? true : false);
          }
        },
        child: BlocBuilder<EditProfileBloc, EditProfileWithInitialState>(
          builder: (context, state) {
            if (state.isLoading) {
              return CustomLoader(
                  child: buildEditProfileLayout(onCameraClick:  () {
                    Navigator.pop(context);
                    editProfileBloc.add(
                        const TriggerImagePickerEvent(isFromCamera: true));
                  },  onGalleryClick:() {
                    Navigator.pop(context);
                    editProfileBloc.add(
                        const TriggerImagePickerEvent(isFromCamera: false));
                  }, context:  context, state: state));
            } else {
              return buildEditProfileLayout(onCameraClick:  () {
                Navigator.pop(context);
                editProfileBloc.add(
                    const TriggerImagePickerEvent(isFromCamera: true));
              },  onGalleryClick:() {
                Navigator.pop(context);
                editProfileBloc.add(
                    const TriggerImagePickerEvent(isFromCamera: false));
              }, context:  context, state: state);
            }
          },
        ),
      ),
    );

  }

  Scaffold buildEditProfileLayout(
      {required BuildContext context, required EditProfileWithInitialState state,
        required dynamic Function() onCameraClick,required dynamic Function() onGalleryClick
      }) {
    return Scaffold(
      appBar:
          const CustomAppBar(title: AppStrings.myAccount_menu_editProfileBtn),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: screenHPadding, vertical: screenVPadding),
          child: Form(
            key: state.formKeyForScaffold,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 20.h),
              buildProfileImage(context: context, state: state, onCameraClick: onCameraClick, onGalleryClick: onGalleryClick),
              buildNameFields(
                  state: state,
                  onTapLeft: () {
                    editProfileBloc.add(
                        const TriggerFocusFields(hasMobileFieldFocus: false));
                  },
                  leftTextFieldValidator: (value) {
                    editProfileBloc.add(TriggerFirstNameValidation(
                        firstName: state.firstNameController.text));
                    return validateFirstName(value!);
                  },
                  onTapRight: () {
                    editProfileBloc.add(
                        const TriggerFocusFields(hasMobileFieldFocus: false));
                  },
                  rightTextFieldValidator: (value) {
                    editProfileBloc.add(TriggerLastNameValidation(
                        lastName: state.lastNameController.text));
                    return validateLastName(value!);
                  }),
              buildBirthdayField(
                  state: state,
                  context: context,
                  validator: (value) {
                    editProfileBloc.add(TriggerValidateBirthday(value: value!));
                    return validateBirthday(value!);
                  },
                  onTap: () {
                    editProfileBloc
                        .add(TriggerUpdateBirthday(context: context));
                  }),
              buildMobileNumberField(
                  state: state,
                  onTap: () {
                    editProfileBloc.add(
                        const TriggerFocusFields(hasMobileFieldFocus: true));
                  },
                  onChanged: (value) {
                    editProfileBloc.add(
                      TriggerOnChangeMobileNumber(
                          mobileNumber: value!.completeNumber,
                          code: value.countryISOCode),
                    );
                  }),
              buildAddressField(
                  state: state,
                  onTap: () {
                    editProfileBloc.add(
                        const TriggerFocusFields(hasMobileFieldFocus: false));
                  },
                  validator: (value) {
                    editProfileBloc
                        .add(TriggerAddressValidation(address: value!));
                    return validateAddress(value);
                  }),
              buildUpdateButton(
                  state: state,
                  onTap: () {
                    editProfileBloc.add(
                      TriggerMobileNumberValidation(
                          birthday: '',
                          isFirstNameValid: state.isFirstNameInvalid,
                          isLastNameValid: state.isLastNameInvalid,
                          isAddressValid: state.isAddressInvalid,
                          mobileNumber: state.mobileNumberController.text,
                          minLength: state.minLength,
                          code: state.code,
                          lastName: state.lastNameController.text,
                          address: state.addressController.text,
                          firstName: state.firstNameController.text,
                          formKeyForScaffold: state.formKeyForScaffold),
                    );
                  }),
              buildChangeEMailSection(editProfileBloc: editProfileBloc, state: state, context: context),
              buildDeleteOrDeactivateAccountButton(context)
            ]),
          )),
    );
  }



}
