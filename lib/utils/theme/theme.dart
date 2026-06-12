import 'package:admin/utils/theme/custom_themes/appbar_theme.dart';
import 'package:admin/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:admin/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:admin/utils/theme/custom_themes/chip_theme.dart';
import 'package:admin/utils/theme/custom_themes/elevated_button.dart';
import 'package:admin/utils/theme/custom_themes/outline_button_theme.dart';
import 'package:admin/utils/theme/custom_themes/text_field_theme.dart';
import 'package:admin/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';


class JAppTheme{
  JAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme:JTextTheme.lightTextTheme ,
    chipTheme: JChipTheme.lightChipTheme,
    elevatedButtonTheme: JElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: JAppBarTheme.lightAppBarTheme,
    checkboxTheme: JCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: JBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: JOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: JTextFormFieldTheme.lightInputDecorationTheme,

  );
  static ThemeData darkTheme = ThemeData(
     useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme:JTextTheme.darkTextTheme,
    chipTheme: JChipTheme.darkChipTheme,
    elevatedButtonTheme: JElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: JAppBarTheme.darkAppBarTheme,
    checkboxTheme: JCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: JBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: JOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: JTextFormFieldTheme.darkInputDecorationTheme,

  );
}