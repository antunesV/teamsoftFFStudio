// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';

SharedPreferences? _prefs;

abstract class FlutterFlowTheme {
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();

  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static FlutterFlowTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color tsInfo100;
  late Color tsInfo200;
  late Color tsInfo300;
  late Color tsInfo400;
  late Color tsInfo500;
  late Color tsInfo600;
  late Color tsSuccess100;
  late Color tsSuccess200;
  late Color tsSuccess300;
  late Color tsSuccess400;
  late Color tsSuccess500;
  late Color tsSuccess600;
  late Color tsWarning100;
  late Color tsWarning200;
  late Color tsWarning300;
  late Color tsWarning400;
  late Color tsWarning500;
  late Color tsWarning600;
  late Color tsDanger100;
  late Color tsDanger200;
  late Color tsDanger300;
  late Color tsDanger400;
  late Color tsDanger500;
  late Color tsDanger600;
  late Color tsPrimary50;
  late Color tsPrimary100;
  late Color tsPrimary200;
  late Color tsPrimary300;
  late Color tsPrimary400;
  late Color tsPrimary500;
  late Color tsPrimary600;
  late Color tsPrimary700;
  late Color tsPrimary800;
  late Color tsPrimary900;
  late Color tsPrimaryDefault;
  late Color tsSecondary50;
  late Color tsSecondary100;
  late Color tsSecondary200;
  late Color tsSecondary300;
  late Color tsSecondary400;
  late Color tsSecondary500;
  late Color tsSecondary600;
  late Color tsSecondary700;
  late Color tsSecondary800;
  late Color tsSecondary900;
  late Color tsSecondaryDefault;
  late Color tsTertiary50;
  late Color tsTertiary100;
  late Color tsTertiary200;
  late Color tsTertiary300;
  late Color tsTertiary400;
  late Color tsTertiary500;
  late Color tsTertiary600;
  late Color tsTertiary700;
  late Color tsTertiary800;
  late Color tsTertiary900;
  late Color tsTertiaryDefault;
  late Color tsNeutral0;
  late Color tsNeutral50;
  late Color tsNeutral100;
  late Color tsNeutral200;
  late Color tsNeutral300;
  late Color tsNeutral400;
  late Color tsNeutral500;
  late Color tsNeutral600;
  late Color tsNeutral700;
  late Color tsNeutral750;
  late Color tsNeutral800;
  late Color tsNeutral850;
  late Color tsNeutral900;
  late Color tsNeutral1000;
  late Color tsTextDefault;
  late Color tsTextInverter;
  late Color tsNeutral950;

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  bool get displayLargeIsCustom => typography.displayLargeIsCustom;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  bool get displayMediumIsCustom => typography.displayMediumIsCustom;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  bool get displaySmallIsCustom => typography.displaySmallIsCustom;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  bool get headlineLargeIsCustom => typography.headlineLargeIsCustom;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  bool get headlineMediumIsCustom => typography.headlineMediumIsCustom;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  bool get headlineSmallIsCustom => typography.headlineSmallIsCustom;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  bool get titleLargeIsCustom => typography.titleLargeIsCustom;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  bool get titleMediumIsCustom => typography.titleMediumIsCustom;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  bool get titleSmallIsCustom => typography.titleSmallIsCustom;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  bool get labelLargeIsCustom => typography.labelLargeIsCustom;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  bool get labelMediumIsCustom => typography.labelMediumIsCustom;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  bool get labelSmallIsCustom => typography.labelSmallIsCustom;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  bool get bodyLargeIsCustom => typography.bodyLargeIsCustom;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  bool get bodyMediumIsCustom => typography.bodyMediumIsCustom;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  bool get bodySmallIsCustom => typography.bodySmallIsCustom;
  TextStyle get bodySmall => typography.bodySmall;
  String get tsFontNormal5xlFamily => typography.tsFontNormal5xlFamily;
  TextStyle get tsFontNormal5xl => typography.tsFontNormal5xl;
  String get tsFontMedium5xlFamily => typography.tsFontMedium5xlFamily;
  TextStyle get tsFontMedium5xl => typography.tsFontMedium5xl;
  String get tsFontSemibold5xlFamily => typography.tsFontSemibold5xlFamily;
  TextStyle get tsFontSemibold5xl => typography.tsFontSemibold5xl;
  String get tsFontBold5xlFamily => typography.tsFontBold5xlFamily;
  TextStyle get tsFontBold5xl => typography.tsFontBold5xl;
  String get tsFontNormal4xlFamily => typography.tsFontNormal4xlFamily;
  TextStyle get tsFontNormal4xl => typography.tsFontNormal4xl;
  String get tsFontMedium4xlFamily => typography.tsFontMedium4xlFamily;
  TextStyle get tsFontMedium4xl => typography.tsFontMedium4xl;
  String get tsFontSemibold4xlFamily => typography.tsFontSemibold4xlFamily;
  TextStyle get tsFontSemibold4xl => typography.tsFontSemibold4xl;
  String get tsFontBold4xlFamily => typography.tsFontBold4xlFamily;
  TextStyle get tsFontBold4xl => typography.tsFontBold4xl;
  String get tsFontNormal3xlFamily => typography.tsFontNormal3xlFamily;
  TextStyle get tsFontNormal3xl => typography.tsFontNormal3xl;
  String get tsFontMedium3xlFamily => typography.tsFontMedium3xlFamily;
  TextStyle get tsFontMedium3xl => typography.tsFontMedium3xl;
  String get tsFontSemibold3xlFamily => typography.tsFontSemibold3xlFamily;
  TextStyle get tsFontSemibold3xl => typography.tsFontSemibold3xl;
  String get tsFontBold3xlFamily => typography.tsFontBold3xlFamily;
  TextStyle get tsFontBold3xl => typography.tsFontBold3xl;
  String get tsFontNormal2xlFamily => typography.tsFontNormal2xlFamily;
  TextStyle get tsFontNormal2xl => typography.tsFontNormal2xl;
  String get tsFontMedium2xlFamily => typography.tsFontMedium2xlFamily;
  TextStyle get tsFontMedium2xl => typography.tsFontMedium2xl;
  String get tsFontSemibold2xlFamily => typography.tsFontSemibold2xlFamily;
  TextStyle get tsFontSemibold2xl => typography.tsFontSemibold2xl;
  String get tsFontBold2xlFamily => typography.tsFontBold2xlFamily;
  TextStyle get tsFontBold2xl => typography.tsFontBold2xl;
  String get tsFontNormalXlFamily => typography.tsFontNormalXlFamily;
  TextStyle get tsFontNormalXl => typography.tsFontNormalXl;
  String get tsFontMediumXlFamily => typography.tsFontMediumXlFamily;
  TextStyle get tsFontMediumXl => typography.tsFontMediumXl;
  String get tsFontSemiboldXlFamily => typography.tsFontSemiboldXlFamily;
  TextStyle get tsFontSemiboldXl => typography.tsFontSemiboldXl;
  String get tsFontBoldXlFamily => typography.tsFontBoldXlFamily;
  TextStyle get tsFontBoldXl => typography.tsFontBoldXl;
  String get tsFontNormalLgFamily => typography.tsFontNormalLgFamily;
  TextStyle get tsFontNormalLg => typography.tsFontNormalLg;
  String get tsFontMediumLgFamily => typography.tsFontMediumLgFamily;
  TextStyle get tsFontMediumLg => typography.tsFontMediumLg;
  String get tsFontSemiboldLgFamily => typography.tsFontSemiboldLgFamily;
  TextStyle get tsFontSemiboldLg => typography.tsFontSemiboldLg;
  String get tsFontBoldLgFamily => typography.tsFontBoldLgFamily;
  TextStyle get tsFontBoldLg => typography.tsFontBoldLg;
  String get tsFontNormalBaseFamily => typography.tsFontNormalBaseFamily;
  TextStyle get tsFontNormalBase => typography.tsFontNormalBase;
  String get tsFontMediumBaseFamily => typography.tsFontMediumBaseFamily;
  TextStyle get tsFontMediumBase => typography.tsFontMediumBase;
  String get tsFontSemiboldBaseFamily => typography.tsFontSemiboldBaseFamily;
  TextStyle get tsFontSemiboldBase => typography.tsFontSemiboldBase;
  String get tsFontBoldBaseFamily => typography.tsFontBoldBaseFamily;
  TextStyle get tsFontBoldBase => typography.tsFontBoldBase;
  String get tsFontNormalSmFamily => typography.tsFontNormalSmFamily;
  TextStyle get tsFontNormalSm => typography.tsFontNormalSm;
  String get tsFontMediumSmFamily => typography.tsFontMediumSmFamily;
  TextStyle get tsFontMediumSm => typography.tsFontMediumSm;
  String get tsFontSemiboldSmFamily => typography.tsFontSemiboldSmFamily;
  TextStyle get tsFontSemiboldSm => typography.tsFontSemiboldSm;
  String get tsFontBoldSmFamily => typography.tsFontBoldSmFamily;
  TextStyle get tsFontBoldSm => typography.tsFontBoldSm;
  String get tsFontNormalXsFamily => typography.tsFontNormalXsFamily;
  TextStyle get tsFontNormalXs => typography.tsFontNormalXs;
  String get tsFontMediumXsFamily => typography.tsFontMediumXsFamily;
  TextStyle get tsFontMediumXs => typography.tsFontMediumXs;
  String get tsFontSemiboldXsFamily => typography.tsFontSemiboldXsFamily;
  TextStyle get tsFontSemiboldXs => typography.tsFontSemiboldXs;
  String get tsFontBoldXsFamily => typography.tsFontBoldXsFamily;
  TextStyle get tsFontBoldXs => typography.tsFontBoldXs;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF4B39EF);
  late Color secondary = const Color(0xFF39D2C0);
  late Color tertiary = const Color(0xFFEE8B60);
  late Color alternate = const Color(0xFFE0E3E7);
  late Color primaryText = const Color(0xFF14181B);
  late Color secondaryText = const Color(0xFF57636C);
  late Color primaryBackground = const Color(0xFFF1F4F8);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color accent1 = const Color(0x4C4B39EF);
  late Color accent2 = const Color(0x4D39D2C0);
  late Color accent3 = const Color(0x4DEE8B60);
  late Color accent4 = const Color(0xCCFFFFFF);
  late Color success = const Color(0xFF249689);
  late Color warning = const Color(0xFFF9CF58);
  late Color error = const Color(0xFFFF5963);
  late Color info = const Color(0xFFFFFFFF);

  late Color tsInfo100 = const Color(0xFFC9D8F7);
  late Color tsInfo200 = const Color(0xFF9DB8F0);
  late Color tsInfo300 = const Color(0xFF6891E9);
  late Color tsInfo400 = const Color(0xFF3A70E2);
  late Color tsInfo500 = const Color(0xFF17419C);
  late Color tsInfo600 = const Color(0xFF0F2B66);
  late Color tsSuccess100 = const Color(0xFFACECC4);
  late Color tsSuccess200 = const Color(0xFF82E3A7);
  late Color tsSuccess300 = const Color(0xFF39C66F);
  late Color tsSuccess400 = const Color(0xFF26A657);
  late Color tsSuccess500 = const Color(0xFF1C7D41);
  late Color tsSuccess600 = const Color(0xFF13532B);
  late Color tsWarning100 = const Color(0xFFFEF9C3);
  late Color tsWarning200 = const Color(0xFFFEF08A);
  late Color tsWarning300 = const Color(0xFFFDE047);
  late Color tsWarning400 = const Color(0xFFFACC15);
  late Color tsWarning500 = const Color(0xFFCA8A04);
  late Color tsWarning600 = const Color(0xFF854D0E);
  late Color tsDanger100 = const Color(0xFFF8C9CA);
  late Color tsDanger200 = const Color(0xFFEF8F91);
  late Color tsDanger300 = const Color(0xFFE96265);
  late Color tsDanger400 = const Color(0xFFE43538);
  late Color tsDanger500 = const Color(0xFF9D1618);
  late Color tsDanger600 = const Color(0xFF670E10);
  late Color tsPrimary50 = const Color(0xFFEAFAF4);
  late Color tsPrimary100 = const Color(0xFFD5F6E9);
  late Color tsPrimary200 = const Color(0xFFABEDD3);
  late Color tsPrimary300 = const Color(0xFF81E4BD);
  late Color tsPrimary400 = const Color(0xFF57DBA7);
  late Color tsPrimary500 = const Color(0xFF2DD291);
  late Color tsPrimary600 = const Color(0xFF24A874);
  late Color tsPrimary700 = const Color(0xFF1B7E57);
  late Color tsPrimary800 = const Color(0xFF12543A);
  late Color tsPrimary900 = const Color(0xFF092A1D);
  late Color tsPrimaryDefault = const Color(0xFF12543A);
  late Color tsSecondary50 = const Color(0xFFFEF5E6);
  late Color tsSecondary100 = const Color(0xFFFDEACE);
  late Color tsSecondary200 = const Color(0xFFFBD69D);
  late Color tsSecondary300 = const Color(0xFFF9C16C);
  late Color tsSecondary400 = const Color(0xFFF8AC3A);
  late Color tsSecondary500 = const Color(0xFFF69709);
  late Color tsSecondary600 = const Color(0xFFC47907);
  late Color tsSecondary700 = const Color(0xFF935B06);
  late Color tsSecondary800 = const Color(0xFF623D04);
  late Color tsSecondary900 = const Color(0xFF311E02);
  late Color tsSecondaryDefault = const Color(0xFFF9BC60);
  late Color tsTertiary50 = const Color(0xFFFBE9EA);
  late Color tsTertiary100 = const Color(0xFFF7D4D4);
  late Color tsTertiary200 = const Color(0xFFEFA9AA);
  late Color tsTertiary300 = const Color(0xFFE67E7F);
  late Color tsTertiary400 = const Color(0xFFDE5455);
  late Color tsTertiary500 = const Color(0xFFD6292A);
  late Color tsTertiary600 = const Color(0xFFAB2122);
  late Color tsTertiary700 = const Color(0xFF801819);
  late Color tsTertiary800 = const Color(0xFF561011);
  late Color tsTertiary900 = const Color(0xFF2B0808);
  late Color tsTertiaryDefault = const Color(0xFFE16162);
  late Color tsNeutral0 = const Color(0xFFFFFFFF);
  late Color tsNeutral50 = const Color(0xFFFAFAFA);
  late Color tsNeutral100 = const Color(0xFFF2F2F2);
  late Color tsNeutral200 = const Color(0xFFE6E6E6);
  late Color tsNeutral300 = const Color(0xFFD9D9D9);
  late Color tsNeutral400 = const Color(0xFFBFBFBF);
  late Color tsNeutral500 = const Color(0xFFA6A6A6);
  late Color tsNeutral600 = const Color(0xFF8C8C8C);
  late Color tsNeutral700 = const Color(0xFF737373);
  late Color tsNeutral750 = const Color(0xFF5D5D5D);
  late Color tsNeutral800 = const Color(0xFF404040);
  late Color tsNeutral850 = const Color(0xFF2F2F2F);
  late Color tsNeutral900 = const Color(0xFF262626);
  late Color tsNeutral1000 = const Color(0xFF212121);
  late Color tsTextDefault = const Color(0xFF212121);
  late Color tsTextInverter = const Color(0xFFFFFFFF);
  late Color tsNeutral950 = const Color(0xFF1F1F1F);
}

abstract class Typography {
  String get displayLargeFamily;
  bool get displayLargeIsCustom;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  bool get displayMediumIsCustom;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  bool get displaySmallIsCustom;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  bool get headlineLargeIsCustom;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  bool get headlineMediumIsCustom;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  bool get headlineSmallIsCustom;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  bool get titleLargeIsCustom;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  bool get titleMediumIsCustom;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  bool get titleSmallIsCustom;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  bool get labelLargeIsCustom;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  bool get labelMediumIsCustom;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  bool get labelSmallIsCustom;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  bool get bodyLargeIsCustom;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  bool get bodyMediumIsCustom;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  bool get bodySmallIsCustom;
  TextStyle get bodySmall;
  String get tsFontNormal5xlFamily;
  TextStyle get tsFontNormal5xl;
  String get tsFontMedium5xlFamily;
  TextStyle get tsFontMedium5xl;
  String get tsFontSemibold5xlFamily;
  TextStyle get tsFontSemibold5xl;
  String get tsFontBold5xlFamily;
  TextStyle get tsFontBold5xl;
  String get tsFontNormal4xlFamily;
  TextStyle get tsFontNormal4xl;
  String get tsFontMedium4xlFamily;
  TextStyle get tsFontMedium4xl;
  String get tsFontSemibold4xlFamily;
  TextStyle get tsFontSemibold4xl;
  String get tsFontBold4xlFamily;
  TextStyle get tsFontBold4xl;
  String get tsFontNormal3xlFamily;
  TextStyle get tsFontNormal3xl;
  String get tsFontMedium3xlFamily;
  TextStyle get tsFontMedium3xl;
  String get tsFontSemibold3xlFamily;
  TextStyle get tsFontSemibold3xl;
  String get tsFontBold3xlFamily;
  TextStyle get tsFontBold3xl;
  String get tsFontNormal2xlFamily;
  TextStyle get tsFontNormal2xl;
  String get tsFontMedium2xlFamily;
  TextStyle get tsFontMedium2xl;
  String get tsFontSemibold2xlFamily;
  TextStyle get tsFontSemibold2xl;
  String get tsFontBold2xlFamily;
  TextStyle get tsFontBold2xl;
  String get tsFontNormalXlFamily;
  TextStyle get tsFontNormalXl;
  String get tsFontMediumXlFamily;
  TextStyle get tsFontMediumXl;
  String get tsFontSemiboldXlFamily;
  TextStyle get tsFontSemiboldXl;
  String get tsFontBoldXlFamily;
  TextStyle get tsFontBoldXl;
  String get tsFontNormalLgFamily;
  TextStyle get tsFontNormalLg;
  String get tsFontMediumLgFamily;
  TextStyle get tsFontMediumLg;
  String get tsFontSemiboldLgFamily;
  TextStyle get tsFontSemiboldLg;
  String get tsFontBoldLgFamily;
  TextStyle get tsFontBoldLg;
  String get tsFontNormalBaseFamily;
  TextStyle get tsFontNormalBase;
  String get tsFontMediumBaseFamily;
  TextStyle get tsFontMediumBase;
  String get tsFontSemiboldBaseFamily;
  TextStyle get tsFontSemiboldBase;
  String get tsFontBoldBaseFamily;
  TextStyle get tsFontBoldBase;
  String get tsFontNormalSmFamily;
  TextStyle get tsFontNormalSm;
  String get tsFontMediumSmFamily;
  TextStyle get tsFontMediumSm;
  String get tsFontSemiboldSmFamily;
  TextStyle get tsFontSemiboldSm;
  String get tsFontBoldSmFamily;
  TextStyle get tsFontBoldSm;
  String get tsFontNormalXsFamily;
  TextStyle get tsFontNormalXs;
  String get tsFontMediumXsFamily;
  TextStyle get tsFontMediumXs;
  String get tsFontSemiboldXsFamily;
  TextStyle get tsFontSemiboldXs;
  String get tsFontBoldXsFamily;
  TextStyle get tsFontBoldXs;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Outfit';
  bool get displayLargeIsCustom => false;
  TextStyle get displayLarge => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 64.0,
      );
  String get displayMediumFamily => 'Outfit';
  bool get displayMediumIsCustom => false;
  TextStyle get displayMedium => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 44.0,
      );
  String get displaySmallFamily => 'Outfit';
  bool get displaySmallIsCustom => false;
  TextStyle get displaySmall => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 36.0,
      );
  String get headlineLargeFamily => 'Outfit';
  bool get headlineLargeIsCustom => false;
  TextStyle get headlineLarge => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 32.0,
      );
  String get headlineMediumFamily => 'Outfit';
  bool get headlineMediumIsCustom => false;
  TextStyle get headlineMedium => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 28.0,
      );
  String get headlineSmallFamily => 'Outfit';
  bool get headlineSmallIsCustom => false;
  TextStyle get headlineSmall => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
      );
  String get titleLargeFamily => 'Outfit';
  bool get titleLargeIsCustom => false;
  TextStyle get titleLarge => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      );
  String get titleMediumFamily => 'Outfit';
  bool get titleMediumIsCustom => false;
  TextStyle get titleMedium => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
      );
  String get titleSmallFamily => 'Outfit';
  bool get titleSmallIsCustom => false;
  TextStyle get titleSmall => GoogleFonts.outfit(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      );
  String get labelLargeFamily => 'Lato';
  bool get labelLargeIsCustom => false;
  TextStyle get labelLarge => GoogleFonts.lato(
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  String get labelMediumFamily => 'Lato';
  bool get labelMediumIsCustom => false;
  TextStyle get labelMedium => GoogleFonts.lato(
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  String get labelSmallFamily => 'Lato';
  bool get labelSmallIsCustom => false;
  TextStyle get labelSmall => GoogleFonts.lato(
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
  String get bodyLargeFamily => 'Lato';
  bool get bodyLargeIsCustom => false;
  TextStyle get bodyLarge => GoogleFonts.lato(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  String get bodyMediumFamily => 'Lato';
  bool get bodyMediumIsCustom => false;
  TextStyle get bodyMedium => GoogleFonts.lato(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  String get bodySmallFamily => 'Lato';
  bool get bodySmallIsCustom => false;
  TextStyle get bodySmall => GoogleFonts.lato(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
  String get tsFontNormal5xlFamily => 'Primary Family';
  TextStyle get tsFontNormal5xl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontSize: 48.0,
      );
  String get tsFontMedium5xlFamily => 'Primary Family';
  TextStyle get tsFontMedium5xl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w500,
        fontSize: 48.0,
      );
  String get tsFontSemibold5xlFamily => 'Primary Family';
  TextStyle get tsFontSemibold5xl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w600,
        fontSize: 48.0,
      );
  String get tsFontBold5xlFamily => 'Primary Family';
  TextStyle get tsFontBold5xl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.bold,
        fontSize: 48.0,
      );
  String get tsFontNormal4xlFamily => 'Primary Family';
  TextStyle get tsFontNormal4xl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontSize: 36.0,
      );
  String get tsFontMedium4xlFamily => 'Primary Family';
  TextStyle get tsFontMedium4xl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w500,
        fontSize: 36.0,
      );
  String get tsFontSemibold4xlFamily => 'Primary Family';
  TextStyle get tsFontSemibold4xl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w600,
        fontSize: 36.0,
      );
  String get tsFontBold4xlFamily => 'Primary Family';
  TextStyle get tsFontBold4xl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.bold,
        fontSize: 36.0,
      );
  String get tsFontNormal3xlFamily => 'Primary Family';
  TextStyle get tsFontNormal3xl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontSize: 30.0,
      );
  String get tsFontMedium3xlFamily => 'Primary Family';
  TextStyle get tsFontMedium3xl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w500,
        fontSize: 30.0,
      );
  String get tsFontSemibold3xlFamily => 'Primary Family';
  TextStyle get tsFontSemibold3xl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w600,
        fontSize: 30.0,
      );
  String get tsFontBold3xlFamily => 'Primary Family';
  TextStyle get tsFontBold3xl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.bold,
        fontSize: 30.0,
      );
  String get tsFontNormal2xlFamily => 'Primary Family';
  TextStyle get tsFontNormal2xl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontSize: 24.0,
      );
  String get tsFontMedium2xlFamily => 'Primary Family';
  TextStyle get tsFontMedium2xl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w500,
        fontSize: 24.0,
      );
  String get tsFontSemibold2xlFamily => 'Primary Family';
  TextStyle get tsFontSemibold2xl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
      );
  String get tsFontBold2xlFamily => 'Primary Family';
  TextStyle get tsFontBold2xl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      );
  String get tsFontNormalXlFamily => 'Primary Family';
  TextStyle get tsFontNormalXl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontSize: 20.0,
      );
  String get tsFontMediumXlFamily => 'Primary Family';
  TextStyle get tsFontMediumXl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
      );
  String get tsFontSemiboldXlFamily => 'Primary Family';
  TextStyle get tsFontSemiboldXl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      );
  String get tsFontBoldXlFamily => 'Primary Family';
  TextStyle get tsFontBoldXl => GoogleFonts.roboto(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      );
  String get tsFontNormalLgFamily => 'Lato';
  TextStyle get tsFontNormalLg => GoogleFonts.lato(
        color: theme.tsNeutral1000,
        fontSize: 18.0,
      );
  String get tsFontMediumLgFamily => 'Lato';
  TextStyle get tsFontMediumLg => GoogleFonts.lato(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
      );
  String get tsFontSemiboldLgFamily => 'Lato';
  TextStyle get tsFontSemiboldLg => GoogleFonts.lato(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
      );
  String get tsFontBoldLgFamily => 'Lato';
  TextStyle get tsFontBoldLg => GoogleFonts.lato(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      );
  String get tsFontNormalBaseFamily => 'Lato';
  TextStyle get tsFontNormalBase => GoogleFonts.lato(
        color: theme.tsNeutral1000,
        fontSize: 16.0,
      );
  String get tsFontMediumBaseFamily => 'Lato';
  TextStyle get tsFontMediumBase => GoogleFonts.lato(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get tsFontSemiboldBaseFamily => 'Lato';
  TextStyle get tsFontSemiboldBase => GoogleFonts.lato(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      );
  String get tsFontBoldBaseFamily => 'Lato';
  TextStyle get tsFontBoldBase => GoogleFonts.lato(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      );
  String get tsFontNormalSmFamily => 'Lato';
  TextStyle get tsFontNormalSm => GoogleFonts.lato(
        color: theme.tsNeutral1000,
        fontSize: 14.0,
      );
  String get tsFontMediumSmFamily => 'Lato';
  TextStyle get tsFontMediumSm => GoogleFonts.lato(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );
  String get tsFontSemiboldSmFamily => 'Lato';
  TextStyle get tsFontSemiboldSm => GoogleFonts.lato(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
      );
  String get tsFontBoldSmFamily => 'Lato';
  TextStyle get tsFontBoldSm => GoogleFonts.lato(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      );
  String get tsFontNormalXsFamily => 'Lato';
  TextStyle get tsFontNormalXs => GoogleFonts.lato(
        color: theme.tsNeutral1000,
        fontSize: 12.0,
      );
  String get tsFontMediumXsFamily => 'Lato';
  TextStyle get tsFontMediumXs => GoogleFonts.lato(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      );
  String get tsFontSemiboldXsFamily => 'Lato';
  TextStyle get tsFontSemiboldXs => GoogleFonts.lato(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.w600,
        fontSize: 12.0,
      );
  String get tsFontBoldXsFamily => 'Lato';
  TextStyle get tsFontBoldXs => GoogleFonts.lato(
        color: theme.tsNeutral1000,
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
      );
}

class DarkModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF4B39EF);
  late Color secondary = const Color(0xFF39D2C0);
  late Color tertiary = const Color(0xFFEE8B60);
  late Color alternate = const Color(0xFF262D34);
  late Color primaryText = const Color(0xFFFFFFFF);
  late Color secondaryText = const Color(0xFF95A1AC);
  late Color primaryBackground = const Color(0xFF1D2428);
  late Color secondaryBackground = const Color(0xFF14181B);
  late Color accent1 = const Color(0x4C4B39EF);
  late Color accent2 = const Color(0x4D39D2C0);
  late Color accent3 = const Color(0x4DEE8B60);
  late Color accent4 = const Color(0xB2262D34);
  late Color success = const Color(0xFF249689);
  late Color warning = const Color(0xFFF9CF58);
  late Color error = const Color(0xFFFF5963);
  late Color info = const Color(0xFFFFFFFF);

  late Color tsInfo100 = const Color(0xFFC9D8F7);
  late Color tsInfo200 = const Color(0xFF9DB8F0);
  late Color tsInfo300 = const Color(0xFF6891E9);
  late Color tsInfo400 = const Color(0xFF3A70E2);
  late Color tsInfo500 = const Color(0xFF17419C);
  late Color tsInfo600 = const Color(0xFF0F2B66);
  late Color tsSuccess100 = const Color(0xFFACECC4);
  late Color tsSuccess200 = const Color(0xFF82E3A7);
  late Color tsSuccess300 = const Color(0xFF39C66F);
  late Color tsSuccess400 = const Color(0xFF26A657);
  late Color tsSuccess500 = const Color(0xFF1C7D41);
  late Color tsSuccess600 = const Color(0xFF13532B);
  late Color tsWarning100 = const Color(0xFFFEF9C3);
  late Color tsWarning200 = const Color(0xFFFEF08A);
  late Color tsWarning300 = const Color(0xFFFDE047);
  late Color tsWarning400 = const Color(0xFFFACC15);
  late Color tsWarning500 = const Color(0xFFCA8A04);
  late Color tsWarning600 = const Color(0xFF854D0E);
  late Color tsDanger100 = const Color(0xFFF8C9CA);
  late Color tsDanger200 = const Color(0xFFEF8F91);
  late Color tsDanger300 = const Color(0xFFE96265);
  late Color tsDanger400 = const Color(0xFFE43538);
  late Color tsDanger500 = const Color(0xFF9D1618);
  late Color tsDanger600 = const Color(0xFF670E10);
  late Color tsPrimary50 = const Color(0xFFEAFAF4);
  late Color tsPrimary100 = const Color(0xFFD5F6E9);
  late Color tsPrimary200 = const Color(0xFFABEDD3);
  late Color tsPrimary300 = const Color(0xFF81E4BD);
  late Color tsPrimary400 = const Color(0xFF57DBA7);
  late Color tsPrimary500 = const Color(0xFF2DD291);
  late Color tsPrimary600 = const Color(0xFF24A874);
  late Color tsPrimary700 = const Color(0xFF1B7E57);
  late Color tsPrimary800 = const Color(0xFF12543A);
  late Color tsPrimary900 = const Color(0xFF092A1D);
  late Color tsPrimaryDefault = const Color(0xFF12543A);
  late Color tsSecondary50 = const Color(0xFFFEF5E6);
  late Color tsSecondary100 = const Color(0xFFFDEACE);
  late Color tsSecondary200 = const Color(0xFFFBD69D);
  late Color tsSecondary300 = const Color(0xFFF9C16C);
  late Color tsSecondary400 = const Color(0xFFF8AC3A);
  late Color tsSecondary500 = const Color(0xFFF69709);
  late Color tsSecondary600 = const Color(0xFFC47907);
  late Color tsSecondary700 = const Color(0xFF935B06);
  late Color tsSecondary800 = const Color(0xFF623D04);
  late Color tsSecondary900 = const Color(0xFF311E02);
  late Color tsSecondaryDefault = const Color(0xFFF9BC60);
  late Color tsTertiary50 = const Color(0xFFFBE9EA);
  late Color tsTertiary100 = const Color(0xFFF7D4D4);
  late Color tsTertiary200 = const Color(0xFFEFA9AA);
  late Color tsTertiary300 = const Color(0xFFE67E7F);
  late Color tsTertiary400 = const Color(0xFFDE5455);
  late Color tsTertiary500 = const Color(0xFFD6292A);
  late Color tsTertiary600 = const Color(0xFFAB2122);
  late Color tsTertiary700 = const Color(0xFF801819);
  late Color tsTertiary800 = const Color(0xFF561011);
  late Color tsTertiary900 = const Color(0xFF2B0808);
  late Color tsTertiaryDefault = const Color(0xFFE16162);
  late Color tsNeutral0 = const Color(0xFFFFFFFF);
  late Color tsNeutral50 = const Color(0xFFFAFAFA);
  late Color tsNeutral100 = const Color(0xFFF2F2F2);
  late Color tsNeutral200 = const Color(0xFFE6E6E6);
  late Color tsNeutral300 = const Color(0xFFD9D9D9);
  late Color tsNeutral400 = const Color(0xFFBFBFBF);
  late Color tsNeutral500 = const Color(0xFFA6A6A6);
  late Color tsNeutral600 = const Color(0xFF8C8C8C);
  late Color tsNeutral700 = const Color(0xFF737373);
  late Color tsNeutral750 = const Color(0xFF5D5D5D);
  late Color tsNeutral800 = const Color(0xFF404040);
  late Color tsNeutral850 = const Color(0xFF2F2F2F);
  late Color tsNeutral900 = const Color(0xFF262626);
  late Color tsNeutral1000 = const Color(0xFF212121);
  late Color tsTextDefault = const Color(0xFF212121);
  late Color tsTextInverter = const Color(0xFFFFFFFF);
  late Color tsNeutral950 = const Color(0xFF203349);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    TextStyle? font,
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = false,
    TextDecoration? decoration,
    double? lineHeight,
    List<Shadow>? shadows,
    String? package,
  }) {
    if (useGoogleFonts && fontFamily != null) {
      font = GoogleFonts.getFont(fontFamily,
          fontWeight: fontWeight ?? this.fontWeight,
          fontStyle: fontStyle ?? this.fontStyle);
    }

    return font != null
        ? font.copyWith(
            color: color ?? this.color,
            fontSize: fontSize ?? this.fontSize,
            letterSpacing: letterSpacing ?? this.letterSpacing,
            fontWeight: fontWeight ?? this.fontWeight,
            fontStyle: fontStyle ?? this.fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
          )
        : copyWith(
            fontFamily: fontFamily,
            package: package,
            color: color,
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
          );
  }
}
