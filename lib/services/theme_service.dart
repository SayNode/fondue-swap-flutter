import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends GetxService {
  RxBool isDarkMode = false.obs;
  init() async {
    isDarkMode.value = await _isDarkMode();
    print(isDarkMode);
  }

  _isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    final darkmode = prefs.getBool('darkmode');
    if (darkmode == null) {
      print(darkmode);
      prefs.setBool('darkmode', isDarkMode.value);
      return isDarkMode.value;
    } else {
      return darkmode;
    }
  }

  switchTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkmode', !isDarkMode.value);
    isDarkMode.value = (await _isDarkMode());
  }
}
