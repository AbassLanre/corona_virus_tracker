import 'dart:convert';
import 'dart:io';
import 'api_exceptions.dart';
import 'package:http/http.dart' as http;


class ApiBaseHelper{

  Future<dynamic> get(String url) async{
    print('Api get, url $url');
    var responseJson;

    try {
      final response = await http.get(url );
      responseJson = _returnResponse(response);
    } on SocketException{
      print('No net');
      throw FetchDataException('No Internet Connection');
    }
    print('api get received');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response){
    switch (response.statusCode){
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while Communication with server with StatusCode : ${response.statusCode}'
        );
    }
  }
}