
import 'package:gitfeed/api/networking.dart';
import 'package:gitfeed/api/request/repository_request.dart';
import 'package:gitfeed/model/repository.dart';
import 'package:gitfeed/widget/repository_item.dart';
import 'package:gitfeed/worker/repotiroy_worker.dart';

abstract class HomeIntentLogic {

  Future<List<RepositoryItemViewModel>> reload();
  Future<List<RepositoryItemViewModel>> next();
  Repository getRepositoryByID(int id);
  bool shouldBatch();
}

class HomeIntent implements HomeIntentLogic {

  RepositoryWorker _worker;

  List<Repository> _repos;
  bool _hasNext = false;


  HomeIntent() {
    this._worker = RepositoryWorker(networking: Networking());
  }

  @override
  Future<List<RepositoryItemViewModel>> reload() async {

    final req = RepositoryRequest(nextID: null);

    final newRepos = await _worker.fetchList(req);

    _updateHasNext(newRepos);

    _repos = newRepos;
    
    return newRepos.map((e) => RepositoryItemViewModel(e)).toList();
  }
  
  @override
  Future<List<RepositoryItemViewModel>> next() async {
    
    if (_hasNext == false) {
      return Future.error("invalid");
    }

    final lastID = _repos.last.id;
    final req = RepositoryRequest(nextID: lastID);

    final newRepos = await _worker.fetchList(req);
    
    _updateHasNext(newRepos);

    _repos += newRepos;

    return newRepos.map((e) => RepositoryItemViewModel(e)).toList();
  }

  @override
  bool shouldBatch() {
    return _hasNext == true;
  }

  @override
  Repository getRepositoryByID(int id) {

    final index = _repos.indexWhere((element) => element.id == id);

    if (index == null) {
      return null;
    }

    return _repos[index];
  }

  void _updateHasNext(List<Repository> repos) {

    if (repos.length > 0) {
      _hasNext = true;
    } else {
      _hasNext = false;
    }
  }
  
}
