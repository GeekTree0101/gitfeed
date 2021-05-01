import 'package:flutter/material.dart';
import 'package:gitfeed/model/repository.dart';
import 'package:gitfeed/widget/repository_item.dart';
import 'package:gitfeed/widget/toast.dart';

class FavoriteModel extends ChangeNotifier {
  List<RepositoryItemViewModel> get items => _items;
  bool get isEmpty => _items.length == 0;

  // private props
  List<Repository> _repos = [];
  List<RepositoryItemViewModel> _items = [];

  Repository getRepositoryByID(int id) {
    final index = _repos.indexWhere((element) => element.id == id);

    if (index == null) {
      return null;
    }

    return _repos[index];
  }

  GitFeedToastViewModel addFavorite(Repository repo) {

    final isNotExist = !_repos.map((e) => e.id).contains(repo.id);

    if (isNotExist) {
      _repos.insert(0, repo);
      _items.insert(0, RepositoryItemViewModel(repo));
      notifyListeners();
    }

    return GitFeedToastViewModel(
      message: isNotExist ? "success" : "This repository is already added",
      isSuccess: isNotExist
    );
  }

  GitFeedToastViewModel deleteFavorite(int id) {
    final index = _repos.indexWhere((element) => element.id == id);

    if (index != null) {
      _repos.removeAt(index);
      _items.removeAt(index);
      notifyListeners();
    }

    return GitFeedToastViewModel(
      message: index != null ? "success" : id.toString() + " repository not founded",
      isSuccess: index != null
    );
  }
}
