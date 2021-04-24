
import 'package:gitfeed/api/request/repository_request.dart';
import 'package:gitfeed/model/repository.dart';
import 'package:gitfeed/worker/repotiroy_worker.dart';

class RepositoryWorkerSpy implements RepositoryWorkerLogic {

  Future<List<Repository>> fetchListStub;
  int fetchListCalled = 0;

  Future<List<Repository>> fetchList(RepositoryRequest req) {
    fetchListCalled += 1;
    return fetchListStub;
  }
}