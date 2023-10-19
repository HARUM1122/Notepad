import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.light;
  Future<SharedPreferences> prefs_ = SharedPreferences.getInstance();
  ThemeProvider(){
    prefs_.then((SharedPreferences prefs){
      String currentTheme = prefs.getString('theme')??'';
      switch(currentTheme){
        case 'ThemeMode.light':
          themeMode = ThemeMode.light;
        case 'ThemeMode.dark':
          themeMode = ThemeMode.dark;
        default:
          themeMode = ThemeMode.system;
      }
      notifyListeners();
    });
  }
  ThemeData lightTheme(){
    return ThemeData(
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor:Color.fromRGBO(111, 111, 198, 0.431),
        cursorColor:Color.fromRGBO(111, 111, 198, 1),
        selectionHandleColor:Color.fromRGBO(111, 111, 198, 1),
      ),
      canvasColor: Colors.white,
      cardColor: const Color.fromRGBO(238, 238, 238, 1),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Color.fromRGBO(61, 61, 61, 1), // Black color for large titles
          fontFamily: "GGsans",
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
        labelSmall: TextStyle(
          color: Color.fromRGBO(127, 127, 127, 1), // A darker shade of grey for small labels
          fontFamily: "GGsans",
          fontWeight: FontWeight.w700,
          fontSize: 10,
        ),
      ),
    );
  }

  ThemeData darkTheme()=>ThemeData(
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor:Color.fromRGBO(111, 111, 198, 0.431),
      cursorColor:Color.fromRGBO(111, 111, 198, 1),
      selectionHandleColor:Color.fromRGBO(111, 111, 198, 1),
    ),
    canvasColor: const Color.fromRGBO(31, 31, 45,1),
    cardColor: const Color.fromRGBO(38, 38, 54, 1),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0
    ),
    textTheme:const TextTheme(
      titleLarge: TextStyle(
        color:Color.fromRGBO(250, 250, 250, 1),
        fontFamily: "GGsans",
        fontSize:32,
        fontWeight: FontWeight.w700
      ),
      labelSmall:TextStyle(
        color: Color.fromRGBO(81, 79, 93,1),
        fontFamily: "GGsans",
        fontWeight: FontWeight.w600,
        fontSize:10,
      )
    )
  );
  
  void changeTheme(ThemeMode theme){
    themeMode = theme;
    prefs_.then((SharedPreferences prefs)=>prefs.setString('theme',theme.toString()));
    notifyListeners();
  }
}
