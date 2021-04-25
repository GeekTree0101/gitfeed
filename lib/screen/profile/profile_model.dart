import 'package:flutter/material.dart';
import 'package:gitfeed/screen/profile/components/profile_content_view.dart';
import 'package:gitfeed/screen/profile/components/profile_engement_view.dart';
import 'package:gitfeed/worker/auth_worker.dart';

class ProfileModel extends ChangeNotifier {
  ProfileContentViewModel contentViewModel;
  ProfileEngagementViewModel engagementViewModel;
  bool get isError => _isError;
  bool get isLoading => _isLoading;

  AuthWorkerLogic _authWorker;
  bool _isError = false;
  bool _isLoading = false;

  ProfileModel(AuthWorkerLogic authWorker) {
    this._authWorker = authWorker;
  }

  reload() async {
    _isLoading = true;

    try {
      final auth = await _authWorker.getMe();
      contentViewModel = ProfileContentViewModel(
        username: auth.login,
        profileImageURL: auth.profileImageURL,
        company: auth.company
      );
      engagementViewModel = ProfileEngagementViewModel(
        followerCount: auth.followers,
        followingCount: auth.following
      );
      _isError = false;
    } catch (err) {
      _isError = true;
    }

    _isLoading = false;
    
    notifyListeners();
  }
}
