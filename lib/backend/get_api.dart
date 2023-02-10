import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as _http;

class GetRequest {

  static Future<_http.Response> queryDFMApiJson() async {
  
    // print("dotenv.get('SELENDRA_API') ${dotenv.get('SELENDRA_API')}");
    // String _api = dotenv.get('SELENDRA_API');
    return await _http.get(
      Uri.parse("${dotenv.get('SELENDRA_API')}dfm.json"),
      // headers: conceteHeader(),
    );
  }
}