import 'package:shared_preferences/shared_preferences.dart';

String _keyEmail = 'Email';

class SharedPrefLogin {
  static void saveToken({required String email}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_keyEmail, email);
  }

  static Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? token = preferences.getString(_keyEmail);
    return token;
  }

  static void logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
