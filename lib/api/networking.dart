import 'dart:convert';

import 'package:http/http.dart' as http;

enum NetworkMethod {
  GET,
  PUT,
  POST,
  DELETE
}

enum EncodingType {
  QueryString,
  Body
}

class NetworkError {
  int code;
  NetworkErrorData data;

  NetworkError({this.code, this.data});
}

class NetworkErrorData {
  
  String message;
  
  NetworkErrorData({this.message});
}

abstract class NetworkRequest {

  String host;
  String path;
  NetworkMethod method;
  EncodingType encodingType;
  Map<String, dynamic> parameters();
}

abstract class NetworkingLogic {

  Future<http.Response> fetch(NetworkRequest req);
}

class Networking implements NetworkingLogic {

  Map<String, String> headers = {"Content-Type": "application/json"};

  Future<http.Response> fetch(NetworkRequest req) async {

    Uri url;

    switch (req.encodingType) {
      case EncodingType.QueryString:
        url = Uri(host: req.host, path: req.path, queryParameters: req.parameters());
        break;
      case EncodingType.Body:
        url = Uri(host: req.host, path: req.path);
        break;
      default:
        throw UnsupportedError("undefined encoding type");
    }

    Future<http.Response> response;

    switch (req.method) {
      case NetworkMethod.GET:
        response = http.get(
          url,
          headers: headers
        );
        break;
      case NetworkMethod.PUT:
        break;
      case NetworkMethod.POST:
        break;
      case NetworkMethod.DELETE:
        break;
    }
    
    if (response == null) {
      throw UnsupportedError("undefined case");
    }

    return response.then((res) {
      if (res.statusCode == 200) {
        return res;
      }

      final NetworkErrorData data = jsonDecode(res.body);
      return Future.error(NetworkError(code: res.statusCode, data: data));
    });
  }
}
