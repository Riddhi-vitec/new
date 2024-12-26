import 'package:flutter/material.dart';

class AppColor {

  //Color palette of the theme
  /// colorPrimary: Main color for the app's primary UI elements,
  /// such as the toolbar. It serves as a dominant color in the overall design.
  static Color colorPrimary = HexColor.fromHex("#003996");
  /// colorSecondary: A secondary color used for various UI elements.
  /// It complements the primary color and provides visual variety.
  static Color colorSecondary = HexColor.fromHex("#475467");
  /// colorTertiary: This color is used for less prominent UI elements,
  /// such as text paragraphs or descriptions. It is often a subdued or neutral color.
  static Color colorTertiary = HexColor.fromHex("#D0D5DD");
  /// colorAccent: A contrasting color used for highlighting or
  /// accenting specific UI elements. It draws attention to important parts of the interface.
  static Color colorAccent = HexColor.fromHex("#2E90FA");
  /// colorDisable: Represents a disabled state, typically used for
  /// UI elements that are not currently interactive or selectable.
  static Color colorDisable = HexColor.fromHex("#D0D5DD");
  /// colorPrimaryInverse: Inverse or text color against the primary color.
  /// It ensures readability when text is placed on the primary color background.
  static Color colorPrimaryInverse = HexColor.fromHex("#FFFFFF");
  /// colorAbsent: Represents transparency or an absent color.
  /// It is equivalent to making something completely transparent or not visible.
  static Color colorAbsent = Colors.transparent;


  // Color palette of text theme
  /// colorPrimaryText: This color represents the primary text color in the app.
  /// It's used for most of the textual content in the interface,
  /// such as titles, headings, and primary information.
  static Color colorPrimaryText = HexColor.fromHex("#003996");
  /// colorSecondaryText: A secondary text color used for less
  /// important information or elements in the UI.
  /// It complements the primary text color and provides visual hierarchy.
  static Color colorSecondaryText = HexColor.fromHex("#636d7d");
  /// colorTertiaryText: Similar to the secondary text color,
  /// this color is used for additional information or less prominent UI elements.
  /// It often appears in smaller text sizes or less emphasized areas.
  static Color colorTertiaryText = HexColor.fromHex("#7A7E89");
  /// colorAccentText: A text color that corresponds to the accent color used
  /// for highlighting or accenting specific UI elements.
  /// It ensures consistency by using the same color for both
  /// the accent UI elements and their associated text.
  static Color colorAccentText = HexColor.fromHex("#2E90FA");
  /// colorPrimaryTextInverse: This is the inverse or text color against the primary background color.
  /// It ensures readability when text is placed on top of
  /// the primary color background by providing sufficient contrast.
  static Color colorPrimaryTextInverse = HexColor.fromHex("#FFFFFF");

  //Color for specific widgets
  /// colorScaffold: This color represents the background color of the overall
  /// scaffold, providing a consistent base color for the app's main structure.
  static Color colorScaffold = HexColor.fromHex("#F0F7FC");
  /// colorStatusBar: Transparent color for the status bar, indicating that
  /// the status bar allows content behind it to be visible.
  /// It's often used for a clean and modern look.
  static Color colorStatusBar = Colors.transparent;
  /// colorDivider: A color used for dividers or lines that separate different
  /// sections or elements in the UI. It helps in providing visual distinction between content.
  static Color colorDivider = HexColor.fromHex("#D0D5DD");
  /// colorTextFieldBorders: This color is applied to the borders of text fields,
  /// indicating the boundaries of user-input areas.
  /// It enhances the visibility of text fields and contributes to the overall design aesthetics.
  static Color colorTextFieldBorders = HexColor.fromHex('#CFD4DC');


  //Color palette for toast themes
  /// colorError: This color is associated with error messages or notifications,
  /// providing a visual indication of issues or problems that require attention.
  static Color colorError = HexColor.fromHex('#F04438');
  /// colorWarning: The color used for warning messages or notifications,
  /// indicating potential issues or areas that need caution without being critical.
  static Color colorWarning = HexColor.fromHex('#F79009');
  /// colorSuccess: Represents the color for success messages or notifications,
  /// conveying positive feedback or successful operations to the user.
  static Color colorSuccess = HexColor.fromHex('#12B76A');





}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}