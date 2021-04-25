import 'package:flutter/material.dart';
import 'package:gitfeed/screen/profile/components/profile_engement_view.dart';
import 'package:gitfeed/screen/profile/profile_model.dart';
import 'package:gitfeed/widget/avatar.dart';
import 'package:provider/provider.dart';

class ProfileContentViewModel {

  String profileImageURL;
  String username;
  String company;

  ProfileContentViewModel({this.profileImageURL, this.username, this.company});
}

class ProfileContentView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final model = context.watch<ProfileModel>();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            profileInfoView(model.contentViewModel),
            SizedBox(height: 36.0),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: ProfileEngagementView(),
            )
          ],
        ),
      ),
    );
  }

  Widget profileInfoView(ProfileContentViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AvatarWidget(
          profileImageURL: viewModel.profileImageURL,
          value: 96.0
        ),
        SizedBox(height: 24.0),
        Text(
          viewModel.username,
          style: TextStyle(
            fontSize: 24.0, 
            color: Colors.grey[900])),
        SizedBox(height: 8.0),
        Text(
          viewModel.company,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[600]
          ))
      ],
    );
  }
}
