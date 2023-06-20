import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static Future<SharedPreferences> instance() async {
    return await SharedPreferences.getInstance();
  }

  /// Get name
  static Future<String> getName() async {
    final pref = await instance();
    return pref.getString('name') ?? '';
  }

  static setName(String user) async {
    final pref = await instance();
    pref.setString('name', user);
  }

  /// Password
  static Future<String> getPassword() async {
    final pref = await instance();
    return pref.getString('Password') ?? '';
  }

  static setPassword(String user) async {
    final pref = await instance();
    pref.setString('Password', user);
  }

  // setPhoneNumber
  static Future<String> getPhoneNumber() async {
    final pref = await instance();
    return pref.getString('phone_number') ?? '';
  }

  static setPhoneNumber(String phone) async {
    final pref = await instance();
    pref.setString('phone_number', phone);
  }

  // Email
  static Future<String> getEmail() async {
    final pref = await instance();
    return pref.getString('email') ?? '';
  }

  static setEmail(String phone) async {
    final pref = await instance();
    pref.setString('email', phone);
  }

  // getToken
  static Future<String> getToken() async {
    final pref = await instance();
    return pref.getString('token') ?? '';
  }

  static setToken(String token) async {
    final pref = await instance();
    pref.setString('token', token);
  }

  // getRegistered
  static Future<bool> getSaveLogin() async {
    final pref = await instance();
    return pref.getBool('SaveLogin') ?? false;
  }

  static setSaveLogin(bool registered) async {
    final pref = await instance();
    pref.setBool('SaveLogin', registered);
  }

  /// Get language
  static Future<String?> getLanguage() async {
    final pref = await instance();
    return pref.getString('language');
  }

  static Future setLanguage(String language) async {
    final pref = await instance();
    pref.setString('language', language);
  }

  static clearAll() async {
    await setName('');
    await setPassword('');
    await setPhoneNumber('');
    await setEmail('');
    await setToken('');
  }

  Preference._();
}
