
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




enum StylesThemeState{light,dark}

class StyleAppTheme extends Cubit<ThemeData> {

  //final DatabaseManager objectBoxManager = DatabaseManager.empty();

  StyleAppTheme([StylesThemeState? stylesTheme])
      : super(_darkTheme);

  //get stylesTheme => stylesTheme;

  //String? a;
  /*
  void restoreTheme() async {
    //final SettingAppData  _settingData = (await objectBoxManager.getSettingDataBox)!;
    //print(" ObjectBox._initObjectBox(theme: ${_settingData!.theme}) ===  ===");
    //Log.out("ObjectBox"," ObjectBox._initObjectBox(theme: ${_settingData.theme}) ===  ===");
    //this.setTheme(StylesThemeState.values[_settingData.theme]);


    var box = await Hive.openBox<AppSetting>(HiveBoxManager.settingBoxName);

    //AppSetting appSetting = new AppSetting()..language = 0;
    //box.put(AppSetting.keyName, 'David');

    if(box.isEmpty){
      AppSetting appSetting = new AppSetting()..theme = 0 ..language = 0;
      box.put(AppSetting.keyName, appSetting);
    }


    AppSetting? setting = box.get(AppSetting.keyName,)!;

    Log.out("HiveBox","HiveBoxManager.restoreTheme(theme: ${setting.theme}) ===  ===");
    this.setTheme(StylesThemeState.values[setting.theme ?? 0]);




  }
  */
  /// [defaultTheme] return a [StylesThemeState] in arg, if arg null return [StylesThemeState.light]
  static ThemeData defaultTheme([StylesThemeState? stylesTheme]){
    if (stylesTheme != null) {
      switch(stylesTheme){
        case StylesThemeState.light: return _lightTheme;
        case StylesThemeState.dark: return _darkTheme;
      }
    }
    return _lightTheme;
  }
  bool get isDarkMode => state.brightness == Brightness.dark;


  Color get originalPrimaryOrange {
    if(state.brightness == Brightness.dark) {
      return Colors.deepOrange;
    }
    return Colors.orange.shade700;
    //return HexColor('#ff7f00');
  }

  static const Color primaryPurple = Colors.deepPurple;
  static final Color primaryOrange = Colors.deepOrange.shade600;
  static final Color primaryOrange1 = HexColor('#ff7f00'); // Color.fromRGBO(255, 127, 0, 0);
  static const Color primaryBlack = Colors.black;
  static const Color primaryWhite = Colors.white;
  static const Color deepPurple = Colors.deepPurpleAccent;
  static const Color accentColorLight = Colors.cyan;  //HexColor('#54D3C2'); //Colors.cyan;
  static const Color accentColorDark =  accentColorLight;

  static final Color secondaryOrange = Colors.deepOrange.shade800;
  static const Color secondaryPurple = Colors.deepPurple;

  static final Color scaffoldBackgroundColor = Colors.grey.shade200;
  static final Color scaffoldBackgroundColorDark = Colors.grey.shade700;


  /*
  static final Color textColor1 = primaryWhite;
  static final Color textColor2 = primaryBlack;
  static final Color textColor3 = primaryOrange;
  static final Color textColor4 = primaryPurple;*/

  /// light theme
  static final _lightTheme = ThemeData(
    fontFamily: 'ubuntu',
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    primaryColor: primaryOrange,
    primaryColorLight: primaryPurple,
    primaryColorDark: primaryBlack,
    accentColor: accentColorLight,
    //accentColorBrightness: Brightness.light,
    appBarTheme: AppBarTheme(
        backgroundColor: primaryOrange
    ),


    iconTheme: const IconThemeData(
        color: Colors.white
    ),

    textTheme: TextTheme(
      headline5: const TextStyle(color: primaryWhite, fontSize: 24),
      headline6: const TextStyle(color: primaryWhite,),
      bodyText1: const TextStyle(color: primaryWhite,),
      bodyText2: const TextStyle(color: primaryBlack,),
      subtitle1: TextStyle(color: primaryBlack.withOpacity(0.3),),
      subtitle2: const TextStyle(color: primaryPurple,),
    ),

    //primarySwatch: Colors.,
    //visualDensity: VisualDensity.adaptivePlatformDensity,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ),
    brightness: Brightness.light,
  );
  /// dark theme
  static final _darkTheme = ThemeData(
    fontFamily: 'ubuntu',
    scaffoldBackgroundColor: scaffoldBackgroundColorDark,
    primaryColor: secondaryOrange,
    primaryColorLight: Colors.deepPurple, // Colors.deepPurple.shade700,
    primaryColorDark: primaryWhite,
    accentColor: accentColorDark,
    //accentColorBrightness: Brightness.dark,
    appBarTheme: AppBarTheme(
        backgroundColor: secondaryOrange
    ),

    textTheme: TextTheme(
      headline5: const TextStyle(color: primaryWhite, fontSize: 24),
      headline6: const TextStyle(color: primaryWhite,),
      bodyText1: TextStyle(color: primaryBlack,),
      bodyText2: TextStyle(color: primaryWhite,),
      subtitle1: TextStyle(color: primaryWhite.withOpacity(0.3),),
      subtitle2: TextStyle(color: primaryPurple,),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
    ),
    brightness: Brightness.dark,
  );



  /// Toggles the current brightness between light and dark.
  /*void toggleTheme() {
    emit((state.brightness == Brightness.dark) ? _lightTheme : _darkTheme);
    HiveBoxManager().updateTheme((state.brightness == Brightness.dark)
        ? StylesThemeState.light
        : StylesThemeState.dark
    );
  }*/

  /// change [StylesThemeState]
  /*void setTheme(StylesThemeState stylesTheme){
    HiveBoxManager().updateTheme(stylesTheme);
    switch(stylesTheme){
      case StylesThemeState.light:
        emit(_lightTheme);

        break;
      case StylesThemeState.dark:
        emit(_darkTheme);
        break;
    }
  }*/

  static TextTheme _buildTextShopTheme(TextTheme base) {
    const String fontName = 'ubuntu';
    return base.copyWith(
      headline1: base.headline1!.copyWith(fontFamily: fontName),
      headline2: base.headline2!.copyWith(fontFamily: fontName),
      headline3: base.headline3!.copyWith(fontFamily: fontName),
      headline4: base.headline4!.copyWith(fontFamily: fontName),
      headline5: base.headline5!.copyWith(fontFamily: fontName),
      headline6: base.headline6!.copyWith(fontFamily: fontName),
      button: base.button!.copyWith(fontFamily: fontName),
      caption: base.caption!.copyWith(fontFamily: fontName),
      bodyText1: base.bodyText1!.copyWith(fontFamily: fontName),
      bodyText2: base.bodyText2!.copyWith(fontFamily: fontName),
      subtitle1: base.subtitle1!.copyWith(fontFamily: fontName),
      subtitle2: base.subtitle2!.copyWith(fontFamily: fontName),
      overline: base.overline!.copyWith(fontFamily: fontName),
    );
  }

  ThemeData get buildLightShopTheme => _buildLightShopTheme() ;

  ThemeData _buildLightShopTheme()
  {
    final Color primaryColor = HexColor('#54D3C2');
    final Color secondaryColor = HexColor('#54D3C2');
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: Colors.cyan,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: const Color(0xFFFFFFFF),
      scaffoldBackgroundColor: const Color(0xFFF6F6F6),
      errorColor: const Color(0xFFB00023),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextShopTheme(base.textTheme),
      primaryTextTheme: _buildTextShopTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextShopTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}