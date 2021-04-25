

import 'package:gitfeed/model/auth.dart';
import 'package:gitfeed/worker/auth_worker.dart';

class AuthWorkerSpy implements AuthWorkerLogic {

  int getMeCalled = 0;
  Future<Auth> getMeStub;

  @override
  Future<Auth> getMe() {
    getMeCalled += 1;
    return getMeStub;
  }
}