import 'package:flutter/material.dart';
import 'package:gitfeed/model/owner.dart';
import 'package:gitfeed/model/repository.dart';

import 'detail_screen_widget.dart';

class DetailPayload {
  Repository repo;

  DetailPayload({this.repo});
}

class DetailModel extends ChangeNotifier {
  DetailScreenViewModel get viewModel => this._viewModel;
  bool get isLoadFailed => this._isLoadFailed;
  Repository get repo => _repo;

  DetailScreenViewModel _viewModel;
  Repository _repo = null;
  bool _isLoadFailed = false;

  setRepository(Repository repo) {
    this._repo = repo;
  }

  reload() {
    if (_repo.owner == null) {
      _isLoadFailed = true;
      _viewModel = null;
    } else {
      _isLoadFailed = false;
      _viewModel = DetailScreenViewModel(_repo.owner);
    }
  }
}
