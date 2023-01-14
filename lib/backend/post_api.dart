import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as _http;
import 'package:mdw_crew/backend/backend.dart';
import 'package:mdw_crew/service/storage.dart';

class PostRequest {

  static String? _body;

  static Map<String, dynamic>? _tk;
  
  static Map<String, dynamic>? _dfmApi;

  static Future<_http.Response> login(final String email, final String password) async {
  
    _dfmApi = await StorageServices.fetchData('dfm_api');
    
    _body = json.encode({
      "email": email,
      "password": password
    });

    return await _http.post(
      Uri.parse("${_dfmApi!['LOGIN_API']}login/email"),
      headers: conceteHeader(),
      body: _body
    );
  }

  // Check QR Valid Or Not
  static Future<_http.Response> checkFunc(final String eventId, final String qrcodeData) async {
    
    _tk = await StorageServices.fetchData(dotenv.get('REGISTRAION'));
    
    _dfmApi = await StorageServices.fetchData('dfm_api');
    
    _body = json.encode({
      "eventId": eventId,
      "qrcodeData": qrcodeData
    });

    return await _http.post(
      Uri.parse("${_dfmApi!['MDW_API']}admissions/check"),
      headers: conceteHeader(key: 'Authorization', value: _tk!['token']),
      body: _body
    );
  }

  // Second Check To Redeem QR
  static Future<_http.Response> addmissionFunc(final String eventId, final String qrcodeData) async {
    
    _tk = await StorageServices.fetchData(dotenv.get('REGISTRAION'));
    
    _dfmApi = await StorageServices.fetchData('dfm_api');

    _body = json.encode({
      "eventId": "637ff7274903dd71e36fd4e5",
      "qrcodeData": qrcodeData
    });

    return await _http.post(
      Uri.parse("${_dfmApi!['MDW_API']}admissions/enter"),
      headers: conceteHeader(key: 'Authorization', value: _tk!['token']),
      body: _body
    );
  }

  // Check Out
  // static Future<_http.Response> checkOutFunc(final String eventId, final String qrcodeData) async {
    
  //   _tk = await StorageServices.fetchData(dotenv.get('REGISTRAION'));

  //   _body = json.encode({
  //     "eventId": eventId,
  //     "qrcodeData": qrcodeData
  //   });

  //   return await _http.post(
  //     Uri.parse("${dotenv.get('MDW_API')}admissions/enter"),
  //     headers: conceteHeader(key: 'Authorization', value: _tk!['token']),
  //     body: _body
  //   );
  // }

}