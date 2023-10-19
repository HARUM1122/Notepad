import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SettingsProvider extends ChangeNotifier{
  String currentView = "ListView";
  bool isOpened=false;
  double turns = 0.0;
  Future<SharedPreferences> prefs_ = SharedPreferences.getInstance();
  SettingsProvider(){
    prefs_.then((SharedPreferences prefs){
      currentView = prefs.getString("view")??'ListView';
      notifyListeners();
    });
  }
  void changeBool(){
    isOpened=!isOpened;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 150),(){
      turns = isOpened?0.5:0.0;
      notifyListeners();
    });
  }
  void changeView(String view){
    if(view==currentView)return;
    currentView = view;
    prefs_.then((SharedPreferences prefs)=>prefs.setString('view',view));
    notifyListeners();
  }
}