import 'package:flutter/material.dart';
import 'package:gitfeed/screen/profile/profile_model.dart';
import 'package:provider/provider.dart';

class ProfileEngagementViewModel {
  int followerCount;
  int followingCount;

  ProfileEngagementViewModel({this.followerCount, this.followingCount});
}

class ProfileEngagementView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProfileModel>();

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          engageItemView("followers", model.engagementViewModel.followerCount),
          engageItemView("followings", model.engagementViewModel.followingCount)
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[500].withOpacity(0.5),
                spreadRadius: 1.0,
                blurRadius: 8.0,
                offset: Offset(0, 3))
          ]),
    );
  }

  Widget engageItemView(String label, int count) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: count.toDouble() / 2.0, end: count.toDouble()),
      duration: Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
              ),
              SizedBox(height: 4.0),
              Text(value.toInt().toString(),
                  style: TextStyle(fontSize: 24.0, color: Colors.blue[700]))
            ],
          ),
        );
      },
    );
  }

}
