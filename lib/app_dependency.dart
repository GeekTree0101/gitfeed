
import 'package:gitfeed/api/networking.dart';
import 'package:gitfeed/worker/auth_worker.dart';
import 'package:gitfeed/worker/repotiroy_worker.dart';

class AppDependency {

  NetworkingLogic networking;
  RepositoryWorkerLogic repositoryWorker;
  AuthWorkerLogic authWorker;

  AppDependency() {
    this.networking = Networking();
    this.repositoryWorker = RepositoryWorker(networking: this.networking);
    this.authWorker = AuthWorker(networking);
  }

}