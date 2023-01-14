import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: avoid_classes_with_only_static_members
class StorageServices {

  static String? _decode;
  static SharedPreferences? _preferences;

  static Future<void> clearStorage() async {
    _preferences = await SharedPreferences.getInstance();
    await _preferences!.clear();
  }

  static Future<SharedPreferences> storeData(dynamic data, String path) async {
    try {

      _preferences = await SharedPreferences.getInstance();
      _decode = jsonEncode(data);
      
      await _preferences!.setString(path, _decode!);

    } catch (e){
      
      if (kDebugMode) {
        print("Error storeData $e");
      }
    }
    return _preferences!;
  }

  static Future<SharedPreferences> addMoreData(Map<String, dynamic> data, String path) async {
    List<Map<String, dynamic>> ls = [];
    _preferences = await SharedPreferences.getInstance();
    if (_preferences!.containsKey(path)) {
      final dataString = _preferences!.getString(path);

      ls = List<Map<String, dynamic>>.from(jsonDecode(dataString!) as List);
      ls.add(data);
    } else {
      ls.add(data);
    }

    _decode = jsonEncode(ls);
    await _preferences!.setString(path, _decode!);
    return _preferences!;
  }
  // ignore: avoid_positional_boolean_parameters
  static Future<void> saveBool(String key, bool value) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences!.setBool(key, value);
  }

  static Future<bool>? readBool(String key) async {
    _preferences = await SharedPreferences.getInstance();
    final res = _preferences!.getBool(key);

    return res!;
  }

  static Future<SharedPreferences> setUserID(String data, String path) async {
    _preferences = await SharedPreferences.getInstance();
    _decode = jsonEncode(data);
    _preferences!.setString(path, _decode!);
    return _preferences!;
  }

  static Future<dynamic> fetchData(String path) async {
    _preferences = await SharedPreferences.getInstance();

    final data = _preferences!.getString(path);

    if (data == null) {
      return null;
    } else {
      return json.decode(data);
    }
  }

  static Future<void> removeKey(String path) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences!.remove(path);
  }

  static Future<Map?> getSeeds(String? seedType) async {
    _preferences = await SharedPreferences.getInstance();
    String? value = _preferences!.getString('wallet_seed_$seedType');
    if (value != null) {
      return jsonDecode(value);
    }
    return {};
  }

  // static Future<void> queryApiFromGithub(String? seedType) async {
  //   _preferences = await SharedPreferences.getInstance();
  //   String? value = _preferences!.getString('wallet_seed_$seedType');
  //   if (value != null) {
  //     return jsonDecode(value);
  //   }
  // }
}