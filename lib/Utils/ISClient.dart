import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/io_client.dart';
import 'dart:io';

class ISClientO {


  ISClientO._privateConstructor();

  static final instance = ISClientO._privateConstructor();

  static String _baseUrl;

  Future<String> get baseUrl async {

    if(_baseUrl != null && _baseUrl != "") return _baseUrl;
    final prefs = await SharedPreferences.getInstance();
    final key = 'base_url';
    _baseUrl = prefs.getString(key) ?? 'https://connecttest.schueco.com/';
    return _baseUrl;
  }

  Future<List<String>> getProductNumberAutocompletion (String number) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    final url = await baseUrl + "schuecocommercewebservices/v2/schuecobcp/externService/user/" + number;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final js = json.decode(response.body);
      final result = js['results'] as String;
      final list = result.split(',');
      list.removeLast();
      return list;
    }
    else {
      throw Exception('Failed to load Articles');
    }
  }
}