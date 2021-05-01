import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gitfeed/api/request/repository_request.dart';
import 'package:gitfeed/model/repository.dart';
import 'package:gitfeed/widget/repository_item.dart';
import 'package:gitfeed/worker/repotiroy_worker.dart';

class HomeModel extends ChangeNotifier {
  HomeModel(RepositoryWorkerLogic repositoryWorker) {
    this._repositoryWorker = repositoryWorker;
  }

  // MARK: - dependencies
  RepositoryWorkerLogic _repositoryWorker;

  // MARK: - props

  List<RepositoryItemViewModel> get items => _items;
  bool get isFetching => _isFetching;
  bool get isError => _isError;

  List<RepositoryItemViewModel> _items = List<RepositoryItemViewModel>.empty();
  List<Repository> _repos = List<Repository>.empty();
  bool _hasNext = false;
  bool _isFetching = false;
  bool _isError = false;

  reload() async {
    if (_isFetching) {
      return;
    }

    _isFetching = true;

    final req = RepositoryRequest(nextID: null);

    try {
      final newRepos = await _repositoryWorker.fetchList(req);
      _updateHasNext(newRepos);
      _repos = newRepos;
      _items = newRepos.map((e) => RepositoryItemViewModel(e)).toList();
      _isError = false;
    } catch (error) {
      _isError = true;
    }

    _isFetching = false;

    notifyListeners();
  }

  next() async {
    if (_hasNext == false) {
      return;
    }

    if (_isFetching) {
      return;
    }

    _isFetching = true;

    final lastID = _repos.last.id;
    final req = RepositoryRequest(nextID: lastID);

    try {
      final newRepos = await _repositoryWorker.fetchList(req);
      _updateHasNext(newRepos);
      _repos += newRepos;
      _items += newRepos.map((e) => RepositoryItemViewModel(e)).toList();
      _isError = false;
    } catch (error) {
      _isError = true;
    }

    _isFetching = false;
    notifyListeners();
  }

  bool shouldBatch(dynamic notification) {
    if (notification is ScrollNotification) {
      final ScrollNotification scrollNotification = notification;
      return scrollNotification.metrics.pixels ==
              scrollNotification.metrics.maxScrollExtent &&
          _hasNext == true &&
          _isFetching == false;
    }

    return false;
  }

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
