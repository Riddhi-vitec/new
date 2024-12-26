class AppStrings{

  /*
    <featureName>_<subFeature>_<subsubFeature+n>_<componentName>
   */


  static const String internetStatus_foundNoConnection_error = "No Internet Connection";
  static const String routName_defaultRoute_title = 'Undefined route';
  static const String userType_undefinedUser_title = 'Undefined user';

  //Onboarding Module
  static const String onboarding_firstCarousel_title = "Boost Productivity";
  static const String onboarding_firstCarousel_subtitle = "Get more done with less effort";
  static const String onboarding_secondCarousel_title = "Work Seamlessly";
  static const String onboarding_secondCarousel_subtitle = "Work from anywhere, anytime";
  static const String onboarding_thirdCarousel_title = "Achieve Higher Goals";
  static const String onboarding_thirdCarousel_subtitle = "Reach your goals faster and easier";
  static const String onboarding_getStartedBtn = "Let's Get Started!";

  static const String appName = "Vitec Bloc Template";
 //Authentication Module
  static const String authentication_signInAndsignUp_title = "Let's get started";


  //Splash
  static const String splash_title = "Vitec Visuals";

  //SigninView

  static const String authentication_signin_subTitle = "Please, sign in to get started";
  static const String authentication_signin_forgotPassword_text = "Forgot password ?";
  static const String authentication_signin_noAccount_text = "Don't have an account?";
  static const String authentication_signin_socialSignInOption_text = "Or sign in with";
  static const String authentication_signin_signinBtn = "Sign In";

  //SignupView
  static const String authentication_signup_subTitle = "Create an account to get started with Vitec Bloc Repo MVVM";
  static const String authentication_signup_checkBox_preceding_text = 'By signing up,you will agree to our ';
  static const String authentication_signup_checkBox_joiner_text = ' and ';
  static const String authentication_signup_checkBox_GTC_action = 'General terms & conditions';
  static const String authentication_signup_checkBox_PP_action = 'privacy policy';
  static const String authentication_signup_alreadyWithAccount_text = "Already have an account ? ";
  static const String authentication_signup_signInOption_text = "Sign in here";
  static const String authentication_signup_signupBtn = "Sign Up";
  static const String authentication_signup_checkBox_notTicked_error = "Please, accept the general terms & conditions and privacy policy";

  //Otp View
  static const String authentication_otp_screen_title  = "Otp";
  static const String authentication_otp_subTitle  = "E-Mail Verification";
  static const String authentication_otp_timeOut_text  = "Didn't receive the code?";
  static const String authentication_otp_resendOtp_action  = " Resend";
  static String authentication_otp_information_text({required String email, required int fieldLength}) =>
  'We have sent you a $fieldLength-digit code to your e-mail: $email. It can take up to 2 minutes to receive the e-mail. The code is valid for 10 minutes';
  static const String authentication_otp_noEmailReceived_text = "If you did not receive the code please check your spam folder or resend it.";
  static const String authentication_otp_submitBtn = "Verify";
  static const String authentication_otp_validityInformation_text = "The code is valid for 2 minutes.";
  // Forgot password
  static const String authentication_forgotPassword_screen_title = 'Forgot Password';
  static const String authentication_forgotPassword_header= 'Forgot Password!';
  static const String authentication_forgotPassword_subheader = 'Please enter the email associated with your account, and then we’ll send an email with instructions to reset your password.';
  static const String authentication_forgotPassword_rememberPasswordOption_text = 'Remembered password?';

  // Reset password
  static const String authentication_resetPassword_screen_title = 'Reset Password';
  static const String authentication_resetPassword_header= 'Reset Password!';
  static const String authentication_resetPassword_information_text = 'Your new Password must be different from the previously used password';


  //My Account Module
  static const String myAccount_menu_editProfileBtn = "Edit Profile";
  static const String myAccount_menu_changePasswordBtn = "Change Password";
  static const String myAccount_menu_paymentHistoryBtn = "Payment History";
  static const String myAccount_menu_paymentMethodBtn = "Payment Method";
  static const String myAccount_menu_languageAndurrencyBtn = "Language & Currency";
  static const String myAccount_menu_appSettingsBtn = "App Settings";
  static const String myAccount_menu_contactUsBtn = "Contact us";
  static const String myAccount_menu_legalsBtn = "Legals";
  static const String myAccount_menu_rateUsBtn = "Rate Us";
  static const String myAccount_logOutBtn = "Logout";
  static const String myAccount_logOutSeet_confirmLogOutDialog_title = 'Are you sure you want to Logout?';

  //AppSetting View
  /// Here modification suggested are added however more modification will be added during module rework task

  static const String myAccount_appSettings_screen_title = "Application Settings";
  static const String myAccount_appSettings_version_title = "Application Version";
  static const String myAccount_appSettings_buildVersion_title = "Application Build-version";
  static const String myAccount_appSettings_information_title = "App Information";
  static const String myAccount_appSettings_appName_title = "App Name";
  static const String myAccount_appSettings_crashCollection_title = "Data crash collection";
  static const String myAccount_appSettings_crashCollection_description_text ="Enabling crash collection will allow us to build more reliable, well-functional, and joyful application for you.";
  static const String myAccount_appSettings_notification_title = "Notification";
  static const String myAccount_appSettings_notification_description_text =   "Enable notifications so you don’t miss any updates from Vitec Bloc Template.";
  static const String myAccount_appSettings_location_title = "Enable Location";
  static const String myAccount_appSettings_location_description_text =   "Enable notification so you don’t miss any updates from Vitec Bloc Template.";

  static const String myAccount_appSettings_selectLanguage_title  = "Select Language";


  static const String myAccount_appSettings_crashCollection_text =
      "Enabling crash collection will allow us to build more reliable, well-functional, and joyful application for you.";
  static const String myAccount_appSettings_notification_text =
      "Enable notifications so you don’t miss any updates from Vitec Template.";

  static const String myAccount_appSettings_selectLanguage_englishOption = "English";
  static const String myAccount_appSettings_selectLanguage_deutschOption= "Deutsch";

  //Change Password
  static const String myAccount_changePassword_screen_title= "Change Password";


  //EditView
  /// Here modification suggested are added however more modification will be added during module rework task

  static const String myAccount_profileSettings_editView_viewProfileBtn = "View Profile";
  static const String myAccount_profileSettings_editView_uploadProfileBtn = "Upload Profile";
  static const String myAccount_profileSettings_editView_selectProfileBtn = "Select Profile";
  static const String myAccount_profileSettings_editView_updateBtn = "Update";
  static const String myAccount_profileSettings_editView_modalBottomSheet_title = "Update Email Address";
  static const String myAccount_profileSettings_editView_modalBottomSheet_subtitle = "Please add your new email address here and verify the email.";
  static const String myAccount_profileSettings_editView_changeEmailBtn = "Change Email";
  static const String myAccount_profileSettings_editView_changeEmailDescription_text= "The Email Address used to identify your Vitec Bloc Template Account to you and others. You can changes this email addesss but first we need to verification process followed.";
  static const String myAccount_profileSettings_editView_changeProfileImage_cameraBtn = "Camera";
  static const String myAccount_profileSettings_editView_changeProfileImage_galleryBtn = "Gallery";
  static const String myAccount_profileSettings_editView_updateEMail_title = "Update Email Address";
  static const String myAccount_profileSettings_editView_updateEMail_subtitle = "Please add your new email address here and verify the email.";
  static const String myAccount_profileSettings_editView_profileSettingsPhotoTitle = "Profile photo";
  static const String myAccount_profileSettings_editView_imageSizeTooLarge_error = 'Please pick a smaller size image';
  static const String myAccount_profileSettings_editView_deleteAccountBtn = "Delete Account";

 //Deactivate account view
  /// Here modification suggested are added however more modification will be added during module rework task
  static const String myAccount_profileSettings_accountDeletionDialog_title = 'Deactivate your account instead of deleting.';
  static const String myAccount_profileSettings_accountDeletionDialog_deleteAccount_text = 'Deleting your account will permanently remove all your saved data and preferences, and disable connected devices.';
  static const String myAccount_profileSettings_accountDeletionDialog_deactivateAccount_text = 'Deactivating your account temporarily disables it, and you can\'t access your saved data and preferences until you reactivate it.';
  static const String myAccount_profileSettings_accountDeletionDialog_confirmDeletion_text = 'Are you sure you want to Delete your account?';
  static const String myAccount_profileSettings_accountDeletionDialog_confirmDeactivation_text = 'Are you sure you want to Deactivate your account?';
  //Contactus View
  /// Here modification suggested are added however more modification will be added during module rework task
  static const String myAccount_profileSettings_contactUsView_screen_title = 'Contact Us';
  /// Here modification suggested are added however more modification will be added during module rework task
  //Legal Module (tou = Terms of Usage; FOSS = Free open source software)
  static const String myAccount_legals_screen_title = "Legals";
  static const String myAccount_legals_termsConditions_screen_title = "Terms & Conditions";
  static const String myAccount_legals_pp_screen_title = "Privacy Policy";
  static const String myAccount_legals_foss_screen_title = "FOSS";
  static const String myAccount_legals_imprint_screen_title = "Imprint";
  static const String myAccount_legals_menu_tcBtn = "Terms & Conditions";
  static const String myAccount_legals_menu_ppBtn = "Privacy Policy";
  static const String myAccount_legals_menu_fossBtn = "FOSS";
  static const String myAccount_legals_menu_imprintBtn = "Imprint";

  //Account Deletion
  static const myAccount_editProfile_deletionConfirmation_title = "Account Deletion Confirmation";
  static String myAccount_editProfile_deletionConfirmation_otp_information_text({required String email, required int fieldLength}) {  return 'We have sent you a $fieldLength-digit code to confirm the permanent deletion of your account: $email';}
  static String myAccount_editProfile_deletionConfirmation_otp_validityInformation_text = "The code is valid for 10 minutes";
  static String myAccount_editProfile_deletionConfirmation_otp_submitBtn = "Confirmation Deletion";
  static String myAccount_editProfile_deletionConfirmation_otp_noEmailReceived_text = "If you did not receive the code please check your spam folder or resend it.";

  // Notification Module
  static const String notification_screen_title = "Notifications";
  //Notification Details
  static const String notification_details_screen_title = "Notification Details";
  static const String notification_details_body_title = "Here is your notification details:";

  //My Products Module
  static const String myProducts_screen_title = "My Products";
  static const String myProducts_addProductBtn = "Add Product";
  static const String myProducts_editProductBtn = "Edit Product";
  static const String myProducts_addUpdateProductForm_title = "Edit Product";
  static const String myProducts_addUpdateProductForm_chooseFromGalleryBtn = 'Choose From Gallery';
  static const String myProducts_uploadImageSuccessfully_text = 'Your image is ready';


  //Language and currency
  static const String myAccount_languageCurrency_screen_title = 'Language & Currency';
  static const String myAccount_languageCurrency_selectCurrency_title = 'Select Currency';
  static const String myAccount_languageCurrency_selectLanguage_title = 'Select Language';

  // Delete or Deactivate
  static const String myAccount_editProfile_deleteOrDeactivate_screen_title = "Delete or Deactivate Account";
  static const String myAccount_editProfile_deleteOrDeactivate_title = "Deactivate your account instead of deleting.";
  static const String myAccount_editProfile_deleteOrDeactivate_deleteAccount_description_text = "Deleting your account will permanently remove all your saved data and preferences, and disable connected devices. You will not be able to recover your account once it is deleted. Are you sure you want to delete your account?";
  static const String myAccount_editProfile_deleteOrDeactivate_deactivateAccount_description_text = "Deactivating your account temporarily disables it, and you can't access your saved data and preferences until you reactivate it.";

  //Password Validation texts
  static const String passwordValidation_validatesOneLowercaseChar_label = '1 lower case letter';
  static const String passwordValidation_validatesOneUppercaseChar_label = '1 upper case letter';
  static const String passwordValidation_validatesOneDigit_label = '1 digit';
  static const String passwordValidation_validatesOneSpecialChar_label = '1 special character';
  static const String passwordValidation_validatesMinChar_label = '4 characters';

  //Non-edit mode textFields: (#Note: remove strings when not needed; these are suggestions)
  static const String textfield_viewEmail_text = 'Email Address';
  static const String textfield_viewFullName_text = 'Full name';
  static const String textfield_viewFirstName_text = 'First name';
  static const String textfield_viewLastName_text = 'First name';
  static const String textfield_viewDOB_text = "Birth date";
  static const String textfield_viewAge_text = 'Age';
  static const String textfield_viewMobileNo_text = 'Mobile no.';
  static const String textfield_viewAddress_text = 'Address';
  static const String textfield_viewZipCode_text = 'Zip code';

  //Textfield labels: (#Don't use these for non-edit mode)
  static const String textfield_addEmail_text = 'Email Address';
  static const String textfield_addPassword_text = 'Password';
  static const String textfield_addConfirmPassword_text = 'Confirm password';
  static const String textfield_addCurrentPassword_text = 'Current password';
  static const String textfield_addNewPassword_text = 'New password';
  static const String textfield_addFullName_text = 'Full name';
  static const String textfield_addFirstName_text = 'First name';
  static const String textfield_addLastName_text = 'Last name';
  static const String textfield_addAddress_text = 'Address';
  static const String textfield_addZipCode_text = 'Zip code';
  static const String textfield_addAge_text = 'Age';
  static const String textfield_addMessage_text = 'Message';
  static const String textfield_addCardName_text = 'Card holder name';
  static const String textfield_addCardNumber_text = 'Card number';
  static const String textfield_addCVC_text = 'CVC';
  static const String textfield_addExpiryDate_text = 'Expiry date';
  static const String textfield_addMobileNo_text = 'Mobile no.';
  static const String textfield_addSearchBar_text = "Search";
  static const String textfield_addDOB_text = "Birth date";
  static const String textfield_addProductName_text = "Product Name";
  static const String textfield_addProductPrice_text = "Product Price";
  static const String textfield_addProductStock_text = "Product Stock";



  //Textfield hints #for edit mode only
  static const String textfield_addEmail_hint = 'e.g. user@vitec-visual.com';
  static const String textfield_addPassword_hint = 'e.g. Vitec!123456';
  static const String textfield_addConfirmPassword_hint = 'e.g. Vitec!123456';
  static const String textfield_addCurrentPassword_hint= 'e.g. Vitec!123456';
  static const String textfield_addNewPassword_hint = 'e.g Vitec@123456';
  static const String textfield_addFullName_hint = 'e.g. Vitec Visual';
  static const String textfield_addFirstName_hint = 'e.g. Vitec';
  static const String textfield_addLastName_hint = 'e.g. Visual';
  static const String textfield_addAddress_hint = 'e.g. Muldestraße 2, Kornwestheim, Baden-Württemberg 70806, Germany ';
  static const String textfield_addZipCode_hint = 'e.g. 70806';
  static const String textfield_addAge_hint = 'e.g. 18';
  static const String textfield_addMessage_hint = 'e.g. Hello, Vitec Visual';
  static const String textfield_addCardName_hint = 'e.g. Vitec Visual';
  static const String textfield_addCardNumber_hint = 'e.g. 4242424242424242';
  static const String textfield_addCVC_hint = 'e.g. 123';
  static const String textfield_addExpiryDate_hint = 'e.g. 12/35';
  static const String textfield_addMobileNo_hint = 'e.g. +49 1234567891011';
  static const String textfield_addSearchBar_hint = "Search";
  static const String textfield_addDOB_hint = "e.g. 1/31/2000";
  static const String textfield_addProductName_hint = "e.g. Vitec Laptop";
  static const String textfield_addProductPrice_hint = "e.g. USD 750.00";
  static const String textfield_addProductStock_hint = "e.g. 10";

  //RadioButton
  static const String radioBtn_selectGender_title = "Select Gender";
  static const String radioBtn_selectGender_male_option = "Male";
  static const String radioBtn_selectGender_female_option = "Female";

  // Common Buttons
  static const String common_sendBtn = "Send";
  static const String common_cancelBtn = "Cancel";
  static const String common_acceptBtn = "Accept";
  static const String common_declineBtn = "Decline";
  static const String common_deleteBtn = "Delete";
  static const String common_submitBtn = "Submit";
  static const String common_purchaseBtn = "Purchase";
  static const String common_addBtn = "Add";
  static const String common_deactivateBtn = "Deactivate";
  static const String common_continueBtn = "Continue";
  static const String common_confirmBtn = "Confirm";

//AlertDialog
  static const String confirmationDialog_yesBtn = "Yes";
  static const String confirmationDialog_noBtn = "No";
  static const String confirmationDialog_acceptBtn = "Accept";
  static const String confirmationDialog_verifyBtn = "Verify";
  static const String confirmationDialog_declineBtn = "Decline";
  static const String confirmationDialog_cancelBtn = "Cancel";
  static const String confirmationDialog_closeBtn = "Close";
  //Switch
  static const String switch_onBtn = "On";
  static const String switch_offBtn = "Off";


  //Errors
  static const String textfield_addFirstName_emptyField_error = "First name field is required";
  static const String textfield_addFirstName_tooLarge_error = "First Name can't be more than 20 letters";
  static const String textfield_addFirstName_tooSmall_error = "First Name can't be fewer than 4 letters";

  static const String textfield_addLastName_emptyField_error = "Last name field is required";
  static const String textfield_addLastName_tooLarge_error = "Last Name can't be more than 20 letters";
  static const String textfield_addLastName_tooSmall_error = "Last Name can't be fewer than 4 letters";

  static const String textfield_addFullName_emptyField_error = "Full name field is required";
  static const String textfield_addFullName_tooLarge_error = "Full name can't be more than 40 letters";
  static const String textfield_addFullName_tooSmall_error = "Full name can't be fewer than 4 letters";

  static const String textfield_addMobileNo_emptyField_error = "Mobile number field is required";
  static const String textfield_addMobileNo_invalid_error = "Please enter valid phone number";

  static const String textfield_addEmail_emptyField_error = "Email field is required";
  static const String textfield_addEmail_invalid_error = "Please enter valid email";

  static const String textfield_addPassword_emptyField_error = "Password field is required";
  static const String textfield_addPassword_invalid_error = "Please enter valid password";

  static const String textfield_addConfirmPassword_emptyField_error = "Confirm password field is required";
  static const String textfield_addConfirmPassword_mismatch_error = "Confirm password should match your new password";

  static const String textfield_addCurrentPassword_emptyField_error = "Current password field is required";
  static const String textfield_addNewPassword_emptyField_error = "New password field is required";
  static const String textfield_addNewPassword_invalid_error = "Please enter a new valid password";
  static const String textfield_addNewPassword_notNew_error = "New Password can't be the Current one";

  static const String textfield_addMessage_emptyField_error = "Message field is required";
  static const String textfield_addAddress_emptyField_error = "Address field is required";
  static const String textfield_addOtp_emptyField_error = "OTP field is required";

  static const String textfield_addProductName_emptyField_error = "Product name field is required";
  static const String textfield_addProductPrice_emptyfield_error = "Product price field is required";
  static const String textfield_addProductStock_emptyfield_error = "Product stock field is required";
  static const String textfield_addProductName_invalid_error = "Product name field is required";
  static const String textfield_addProductPrice_invalid_error = "Product price field is required";
  static const String textfield_addProductStock_invalid_error = "Product stock field is required";
  static const String textfield_addDob_emptyField_error = "Birth date field is required";
  static const String textfield_addDob_invalid_error = "User must be 18 years or older";

  //Bottom Navigation
  static const String btmNavigation_dashboard_title = "Dashboard";
  static const String btmNavigation_myProducts_title = "My Products"; // replace secondPage with Module name
  static const String btmNavigation_myAccount_title = "My Account";
  //Dashboard
  static const String dashboard_screen_title = "Dashboard";
  static const String dashboard_openDrawer_text = "Open Drawer";
  static const String dashboard_endDrawer_text = "End Drawer";


  //Chat View (not edited yet; left for later task)

  static const String chat_myChats_textfield_addMessage_hint = "Type you text here...";
  static const String chat_myChats_viewBtn =  "Chat View";
  static const String chat_myChats_screen_title = "Chat View";
  static const String chat_myChats_greetingMessage_text= "Thanks for getting in touch with us! Please send us any questions you may have.";






  //Foss View
  //Foss Data
  //clause
  static const String bsd0Clause = "BSD Zero Clause License";
  static const String bsd3ClauseLicence = "BSD 3-Clause License";
  static const String theMitClause = "The MIT License (MIT)";
  static const String mitClause = "MIT License";
  static const String imageLicence = "Apache-2.0, BSD-3-Clause";
  static const String bsd2Clause = "BSD 2-Clause License";
  static const String apacheLicence = "Apache License\nVersion 2.0, January 2004";

  //Copyright
  static const String copyrightFlutterAuthors = "Copyright 2013 The Flutter Authors. All rights reserved.";
  static const String copyrightChromiumAuthors= "Copyright 2017 The Chromium Authors. All rights reserved.";
  static const String copyrightApache2O= "Copyright 2022 Simon Leier\nLicensed under the Apache License, Version 2.0 (the License)";

  static const String cupertinoIcons = "cupertino_icons, ^1.0.2";
  static const String copyrightCupertinoIcons = "Copyright (c) 2016 Vladimir Kharlampidi";

  static const String bloc = "bloc: ^8.1.2";
  static const String copyrightBloc = "Copyright (c) 2018 Felix Angelov";

  static const String flutterBloc = "flutter_bloc: ^8.1.3";
  static const String copyrightFlutterBloc = "Copyright (c) 2018 Felix Angelov";

  static const String equatable = "equatable: ^2.0.5";
  static const String copyrightEquatable = "Copyright (c) 2018 Felix Angelov";

  static const String responsiveFramework = "responsive_framework: ^1.1.1";
  static const String copyRightResponsiveFramework = "Copyright © 2023 Codelessly";

  static const String getIt = "get_it: ^7.6.0";
  static const String copyRightGetIt = "Copyright (c) 2018 Thomas Burkhart";

  static const String deviceInfoPlus = "device_info_plus: ^9.0.3";

  static const String http = "http: ^1.1.0";
  static const String copyrightHttp = "Copyright 2014, the Dart project authors.";

  static const String sharedPreferences = "shared_preferences: ^2.2.2";

  static const String connectivityPlus = "connectivity_plus: ^5.0.1";

  static const String firebaseDynamicLinks = "firebase_dynamic_links: ^5.3.7";
  static const String copyrightFirebaseDynamicLinks=
      "Copyright 2018 The Chromium Authors. All rights reserved.";
  static const String flutterStripe =
      "flutter_stripe: ^9.4.0";
  static const String copyrightFlutterStripe =
      "Copyright 2021 - Stripe, Jaime Blasco, Jonas Bark and Rémon Helmond";

  static const String stripePlatformInterface =
      "stripe_platform_interface: ^9.4.0";

  static const String dartz = "dartz: ^0.10.1";
  static const String copyrightDartz =
      "Copyright (c) 2016, 2017, 2018, 2019, 2020, 2021 Björn Sperber";

  static const String firebaseCore = "firebase_core: ^2.17.0";
  static const String firebaseMessaging = "firebase_messaging: ^14.7.1";
  static const String firebaseCrashlytics = "firebase_crashlytics: ^3.3.7";
  static const String firebaseAuth = "firebase_auth: ^4.12.1";

  static const String googleSignIn = "google_sign_in: ^6.1.5";
  static const String flutterLoginFacebook = "flutter_login_facebook: ^1.8.0";
  static const String copyrightFlutterLoginFacebook = "Copyright 2020 Innim Team.";

  static const String botToast = "bot_toast: ^4.1.3";
  static const String copyRightBotToast =
      "Copyright 2019 MMMzq\nLicensed under the Apache License, Version 2.0 (the License)";

  static const String flutterSvg = "flutter_svg: ^2.0.7";
  static const String copyrightFlutterSvg = "Copyright (c) 2018 Dan Field";

  static const String flutterScreenutil = "flutter_screenutil: ^5.9.0";
  static const String copyRightFlutterScreenutil = "Licensed under the Apache License, Version 2.0 (the License)\n you may not use this file except in compliance with the License.";

  static const String cachedNetworkImage = "cached_network_image: ^3.3.0";
  static const String copyrightCachedNetworkImage =
      "Copyright (c) 2018 Rene Floor";

  static const String packageInfoPlus = "package_info_plus: ^4.2.0";
  static const String copyrightPackageInfoPlus =
      "Copyright (c) 2018 Rene Floor";

  static const String notificationPermissions =
      "notification_permissions: ^0.6.1";
  static const String copyrightNotificationPermissions =
      "Copyright (c) 2019, Gonçalo Palma All rights reserved.";

  static const String appSettingsFoss = "app_settings: ^5.1.1";
  static const String copyrightAppSettings =
      "Copyright (c) 2019 Daniel Spencer";

  static const String percentageIndicator = "percent_indicator: ^4.2.3";
  static const String copyrightPercentageIndicator =
      "Copyright (c) 2018, diegoveloper@gmail.com\nAll rights reserved.";

  static const String isar = "isar: ^3.1.0+1";

  static const String isarFlutterLibs = "isar_flutter_libs";

  static const String intl = "intl: ^0.18.1";
  static const String copyrightIntl = "Copyright 2013, the Dart project authors.";

  static const String flutterLocalNotifications = "flutter_local_notifications: ^16.1.0";
  static const String copyrightFlutterLocalNotifications =
      "Copyright 2018 Michael Bui. All rights reserved.";

  static const String flutterAppBadger =
      "flutter_app_badger: ^1.5.0";

  static const String flutterLocalization = "flutter_localization: ^0.1.14";
  static const String copyrightFlutterLocalization = "Copyright <2020> <mastertipsy>";

  static const String signInWithApple = "sign_in_with_apple: ^5.0.0";
  static const String copyrightSignInWithApple = "Copyright 2019 sign_in_with_apple authors";

  static const String encrypt = "encrypt: ^5.0.3";
  static const String copyrightEncrypt = "Copyright (c) 2018, Leo Cavalcante All rights reserved.";

  static const String filePicker = "file_picker: ^6.1.1";
  static const String copyrightFilePicker = "Copyright (c) 2018 Miguel Ruivo";

  static const String pathProvider = "path_provider: ^2.1.1";

  static const String openFilex = "open_filex: ^4.3.4";
  static const String copyrightOpenFilex = "Copyright 2018 crazecoder. All rights reserved.";

  static const String imagePicker = "image_picker: ^1.0.4";

  static const String imageCropper = "image_cropper: ^5.0.0";
  static const String copyrightImageCropper= "Copyright 2013, the Dart project authors. All rights reserved.";

  static const String flutterWidgetFromHtml = "flutter_widget_from_html: ^0.14.6";
  static const String copyrightFlutterWidgetFromHtml = "Copyright (c) 2020 Dao Hoang Son";

  static const String buildRunner = "build_runner: ^2.4.6";
  static const String copyrightBuildRunner = "Copyright 2016, the Dart project authors.";

  static const String isarGenerator = "isar_generator: ^3.1.0+1";
  static const String copyrightIsarGenerator = "Copyright 2016, the Dart project authors.";

  static const String flutterLauncherIcons = "flutter_launcher_icons: ^0.13.1";
  static const String copyrightFlutterLauncherIcons = "Copyright (c) 2019 Mark O'Sullivan";

  static const String changeAppPackageName = "change_app_package_name: ^1.1.0";
  static const String copyrightChangeAppPackageName = "Copyright (c) 2019 Atiq Samtia";

}