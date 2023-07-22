import 'package:shared_preferences/shared_preferences.dart';

void saveDarkModeState(SharedPreferences prefs, bool isDarkmode) async {
  await prefs.setBool("isDarkMode", isDarkmode);
}

Future<bool> loadDarkModeState(SharedPreferences prefs) async {
  return prefs.getBool("isDarkMode") ?? false;
}
