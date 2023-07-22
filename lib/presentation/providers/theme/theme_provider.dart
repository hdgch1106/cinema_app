import 'package:cinema_app/config/theme/app_theme.dart';
import 'package:cinema_app/config/theme/theme_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<AppTheme> {
  late SharedPreferences prefs;
  ThemeNotifier() : super(AppTheme()) {
    _init();
  }

  _init() async {
    prefs = await SharedPreferences.getInstance();
    bool isDarkmode = await loadDarkModeState(prefs);
    state = state.copyWith(isDarkmode: isDarkmode);
  }

  void toggleDarkmode() {
    bool isDarkmode = !state.isDarkmode;
    state = state.copyWith(isDarkmode: isDarkmode);
    saveDarkModeState(prefs, isDarkmode);
  }
}
