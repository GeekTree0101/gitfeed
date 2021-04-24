import 'package:flutter/material.dart';
import 'package:gitfeed/model/owner.dart';

import 'detail_screen_widget.dart';

class DetailPayload {
  Owner owner;

  DetailPayload({this.owner});
}

class DetailModel extends ChangeNotifier {
  DetailScreenViewModel get viewModel => this._viewModel;
  bool get isLoadFailed => this._isLoadFailed;

  DetailScreenViewModel _viewModel;
  Owner _owner = null;
  bool _isLoadFailed = false;

  setOwner(Owner owner) {
    this._owner = owner;
  }

  reload() {
    if (_owner == null) {
      _isLoadFailed = true;
      _viewModel = null;
    } else {
      _isLoadFailed = false;
      _viewModel = DetailScreenViewModel(_owner);
    }
  }
}
