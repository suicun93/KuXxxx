part of 'const.dart';

const primaryColor = Color(0xFFF7BE23);
const subPrimaryColor = Color(0xFF00A5CC);
// const subPrimaryColor = Color(0xFF563733);

const textColorDefault = Color(0xFF1B1D21);
const Color borderColor = textColorFaint;
const Color focusBorderColor = subPrimaryColor;
const Color errorBorderColor = Color(0xFFD60000);
const Color sosColor = red;
const Color red = Color(0xffF64E60);

const Color textColorFaint = Color(0x7F1B1D21);

const iconColorDefault = Colors.white;

const Color accentColor = Color(0xFFF7F7F7);
const Color buttonDisableColor = Color(0xFFD9D9D9);
const Color backgroundColorDefault = primaryColor;

/// Shadow
const Color shadowColor = Color(0xddDDE5EE);
// const Color shadowColor = const Color(0x7fDDE5EE);
const defaultBoxShadow = BoxShadow(
  color: shadowColor,
  offset: Offset(0, 6),
  blurRadius: 30,
  spreadRadius: 0,
);
const Color backgroundColorShadow = Color(0xfff8f9fb);

const Color hintTextColor = textColorFaint;
const Color errorTextColor = Colors.redAccent;

const Color dividerColorDefault = textColorFaint;

// final selectedMenuItemColor = Color(0xFF24CCBC);
// final defaultMenuItemColor = Color(0xFF777777);

const String fontNameDefault = 'Roboto';

const toolbarHeight = 60.0;

// final Border defaultInputBorderStyle = Border.all(
//   color: subPrimaryColor,
//   width: 1,
//   style: BorderStyle.solid,
// );

const TextStyle _defaultTextStyle = TextStyle(
  fontSize: 14,
  color: textColorDefault,
  fontFamily: fontNameDefault,
  fontWeight: FontWeight.w400,
);

const TextStyle _defaultTextButtonStyle = TextStyle(
  fontWeight: FontWeight.bold,
);

const defaultSystemUiOverlayStyle = SystemUiOverlayStyle(
  // The color of the system bottom navigation bar.
  // Only honored in Android versions O and greater.
  systemNavigationBarColor: Colors.white,
  // The color of the divider between the system's bottom navigation bar and the app's content.
  // Only honored in Android versions P and greater.
  systemNavigationBarDividerColor: Colors.white,
  // The brightness of the system navigation bar icons.
  // Only honored in Android versions O and greater.
  // When set to [Brightness.light], the system navigation bar icons are light.
  // When set to [Brightness.dark], the system navigation bar icons are dark.
  systemNavigationBarIconBrightness: Brightness.dark,
  // The color of top status bar.
  // Only honored in Android version M and greater.
  statusBarColor: Colors.transparent,
  // The brightness of top status bar.
  // Only honored in iOS.
  statusBarBrightness: Brightness.dark,
  // The brightness of the top status bar icons.
  // Only honored in Android version M and greater.
  statusBarIconBrightness: Brightness.light,
);

final homeSystemUiOverlayStyle = defaultSystemUiOverlayStyle.copyWith(
  systemNavigationBarColor: primaryColor,
  systemNavigationBarDividerColor: primaryColor,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
);

final defaultTheme = ThemeData(
  primaryColor: primaryColor,
  hoverColor: subPrimaryColor,
  colorScheme: ColorScheme(
    primary: primaryColor,
    primaryVariant: primaryColor,
    onPrimary: textColorDefault,
    secondary: subPrimaryColor,
    secondaryVariant: subPrimaryColor,
    onSecondary: Colors.white,
    background: backgroundColorDefault,
    onBackground: textColorDefault,
    surface: accentColor,
    onSurface: textColorDefault,
    error: errorTextColor,
    onError: backgroundColorDefault,
    brightness: Brightness.light,
  ),

  /// Font
  fontFamily: fontNameDefault,

  /// Background
  backgroundColor: backgroundColorDefault,
  scaffoldBackgroundColor: backgroundColorDefault,

  /// Text Selection
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: primaryColor,
    selectionColor: primaryColor,
    selectionHandleColor: subPrimaryColor,
  ),

  /// Text
  // final TextStyle _defaultTextStyle = TextStyle(
  // fontSize: 14,
  // color: textColorDefault,
  // fontFamily: fontNameDefault,
  // );
  textTheme: TextTheme(
    // Big title
    // Chữ to màu đen trên cùng(Đăng ký, đăng nhập, ...)
    headline1: _defaultTextStyle.copyWith(
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
    // Big sub title (Chữ ở dưới Big title)
    subtitle1: _defaultTextStyle.copyWith(
      fontSize: 24,
      height: 1.5,
      fontWeight: FontWeight.w400,
      color: textColorFaint,
    ),
    // Title 2 (Tiêu đề thông báo)
    subtitle2: _defaultTextStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    // Body Text 1/BodyText 1
    bodyText1: _defaultTextStyle,
    // Body Text 2/BodyText 2 (BodyText 1 nhưng màu xám)
    bodyText2: _defaultTextStyle.copyWith(color: textColorFaint),
    // Body Text 3/BodyText 3 (BodyText 1 nhưng weight 500)
    headline6: _defaultTextStyle.copyWith(fontWeight: FontWeight.w500),
    // Button
    button: _defaultTextButtonStyle,
    // Caption
    caption: _defaultTextStyle.copyWith(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    // Caption 2
    headline5: _defaultTextStyle.copyWith(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    // Title 3
    headline4: _defaultTextStyle.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    // // Hint
    // headline5: _defaultTextStyle,
  ),

  /// Input Text
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: _defaultTextStyle.copyWith(color: textColorFaint),
    hintStyle: _defaultTextStyle.copyWith(color: textColorFaint),
    errorStyle: _defaultTextStyle.copyWith(color: errorTextColor, fontSize: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.5,
        style: BorderStyle.solid,
        color: borderColor,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.5,
        style: BorderStyle.solid,
        color: borderColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.8,
        style: BorderStyle.solid,
        color: focusBorderColor,
      ),
      gapPadding: 3,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.5,
        style: BorderStyle.solid,
        color: errorTextColor,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.8,
        style: BorderStyle.solid,
        color: red,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  ),

  /// App Bar
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    elevation: 0,
    systemOverlayStyle: defaultSystemUiOverlayStyle,
    foregroundColor: Colors.white,
    textTheme: TextTheme(
      headline6: _defaultTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    toolbarTextStyle: _defaultTextStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    centerTitle: true,
    iconTheme: IconThemeData(color: iconColorDefault),
    shadowColor: Colors.transparent,
  ),

  /// Button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) => states.contains(MaterialState.disabled)
            ? buttonDisableColor
            : subPrimaryColor,
      ),
      alignment: Alignment.center,
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16)),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) => states.contains(MaterialState.disabled)
            ? textColorFaint
            : Colors.white,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      alignment: Alignment.center,
      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16)),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      foregroundColor: MaterialStateProperty.all(subPrimaryColor),
      overlayColor: MaterialStateProperty.all(Colors.black12),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          side: BorderSide(
            color: subPrimaryColor,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  ),

  /// Divider
  dividerTheme: DividerThemeData(
    color: dividerColorDefault,
    space: 0,
    thickness: 0.5,
  ),
);
