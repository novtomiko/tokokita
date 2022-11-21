import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:perpustakaansekolah/helpers/user_info.dart';
import 'app_exception.dart';

class Api{
  Future<dynamic> post(String url, dynamic data) async {
    var token = await UserInfo().getToken();
    var responseJson;
    var uri=Uri.parse(url);
    try {
      final response = await http.post(uri, body: data, headers: {
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> get(String url) async {
    var token = await UserInfo().getToken();
    var responseJson;
    var uri=Uri.parse(url);
    try {
      final response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var token = await UserInfo().getToken();
    var responseJson;
    var uri=Uri.parse(url);
    try {
      final response = await http.delete(uri, headers: {
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');        
    }
  }
}