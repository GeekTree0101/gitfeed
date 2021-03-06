import 'dart:convert';

import 'package:gitfeed/api/networking.dart';
import 'package:gitfeed/api/request/repository_request.dart';
import 'package:gitfeed/model/repository.dart';

abstract class RepositoryWorkerLogic {
  Future<List<Repository>> fetchList(RepositoryRequest req);
}

class RepositoryWorker implements RepositoryWorkerLogic {
  NetworkingLogic networking;

  RepositoryWorker({this.networking});

  @override
  Future<List<Repository>> fetchList(RepositoryRequest req) async {
    return networking.fetch(req).then((res) {
      final List<dynamic> jsonArray = jsonDecode(res.body);
      final repos = jsonArray.map((json) => Repository.fromJson(json));
      return repos.toList();
    });
  }
}
