import 'package:get_storage/get_storage.dart';

class SharedPrefs {
  static Future<void> writeValue(String key, dynamic value) async {
    await GetStorage().write(key, value);
  }

  static T read<T>(String key) {
    return GetStorage().read(key);
  }

  static String readStringValue(String key) {
    return GetStorage().read(key) ?? "";
  }

  static bool readBoolValue(String key) {
    return GetStorage().read(key) ?? false;
  }

  static Future<void> clearAll() async {
    await GetStorage().erase();
    return;
  }

  static Future<void> remove(String key) async {
    return await GetStorage().remove(key);
  }
}

class PrefConstants {
  static const String IS_LOGGED_IN = "isLoggedIn";
  static const String IS_OFFLINE = "isOffline";
  static const String ACCESS_TOKEN = "token";
  static const String MEMBER_DETAILS = "lastLocation";
  static const String USER_DETAILS = "userDetails";
  static const String SELECTED_LANGUAGE = "selectedLanguage";
  static const String IS_SKIP_LOGIN = "isSkipLogin";
  static const String OFFLINE_LAST_SELECTED_STATE = "offlineLastSelectedState";
  static const String OFFLINE_PIN = "offlinePIN";
  static const String OFFLINE_LAST_SELECTED_DIVISION =
      "offlineLastSelectedDivision";
}
