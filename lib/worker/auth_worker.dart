
import 'dart:convert';

import 'package:gitfeed/api/networking.dart';
import 'package:gitfeed/api/request/me_request.dart';
import 'package:gitfeed/model/auth.dart';

abstract class AuthWorkerLogic {
  
  Future<Auth> getMe();
}

class AuthWorker implements AuthWorkerLogic {

  NetworkingLogic _networking;

  AuthWorker(NetworkingLogic networking) {
    this._networking = networking;
  }

  @override
  Future<Auth> getMe() {
    
    final req = MeRequest();

    return this._networking.fetch(req).then((response) {
      final json = jsonDecode(response.body);
      return Auth.fromJson(json);
    });
  }

}