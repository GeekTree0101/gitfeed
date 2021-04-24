import 'dart:convert';

import 'package:http/http.dart' as http;

enum NetworkMethod { GET, PUT, POST, DELETE }

enum EncodingType { QueryString, Body }

class NetworkError {
  int code;
  NetworkErrorData data;

  NetworkError({this.code, this.data});
}

class NetworkErrorData {
  String message;

  NetworkErrorData({this.message});

  factory NetworkErrorData.fromJson(Map<String, dynamic> json) {
    return NetworkErrorData(message: json["message"]);
  }
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
  static final Networking _instance = Networking.once();

  Networking.once() {/** instance created once */}

  factory Networking() {
    return _instance;
  }

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization": "token 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",
  };

  Future<http.Response> fetch(NetworkRequest req) async {
    Uri url;

    switch (req.encodingType) {
      case EncodingType.QueryString:
        url = Uri.https(req.host, req.path, req.parameters());
        break;
      case EncodingType.Body:
        url = Uri.https(req.host, req.path);
        break;
      default:
        throw UnsupportedError("undefined encoding type");
    }

    Future<http.Response> response;

    switch (req.method) {
      case NetworkMethod.GET:
        response = http.get(url, headers: headers);
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

      final NetworkErrorData data =
          NetworkErrorData.fromJson(jsonDecode(res.body));
      return Future.error(NetworkError(code: res.statusCode, data: data));
    });
  }
}
