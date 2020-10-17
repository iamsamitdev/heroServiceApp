import 'dart:convert';

import 'package:http/http.dart' as http;

class CallAPI {

  _setHeaders() => {
    'Content-Type':'application/json',
    'Accept': 'application/json'
  };

  final String baseAPIURL = 'https://www.itgenius.co.th/sandbox_api/flutteradvapi/public/api/';

  // Login API
  loginAPI(data) async {
    return await http.post(
      baseAPIURL+'login',
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }

}