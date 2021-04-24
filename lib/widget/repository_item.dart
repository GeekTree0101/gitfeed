import 'package:flutter/material.dart';
import 'package:gitfeed/model/repository.dart';
import 'package:gitfeed/widget/avatar.dart';

class RepositoryItemViewModel {
  int id;
  String title;
  String description;
  String profileImageURL;
  String username;

  RepositoryItemViewModel(Repository repository) {
    this.id = repository.id;
    this.title = repository.name;
    this.description = repository.description;
    this.profileImageURL = repository.owner.profileImageURL;
    this.username = repository.owner.username;
  }
}

class RepositoryItemWidget extends StatelessWidget {

  final Function() onTap;
  final RepositoryItemViewModel viewModel;

  // constructor
  RepositoryItemWidget({this.viewModel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () {
        onTap();
      },
      child: Container(
        child: Column(
          children: [
            content(context),
            Container(height: 1.0, color: Colors.grey[300])
          ],
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Padding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          repositoryInfo(context),
          SizedBox(height: 12.0),
          userInfo(context)
        ],
      ),
      padding: EdgeInsets.all(12.0),
    );
  }

  Widget repositoryInfo(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(this.viewModel.title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          )),
      SizedBox(height: 8.0),
      Text(this.viewModel.description ?? "",
          style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.normal,
              fontSize: 16.0))
    ]);
  }

  Widget userInfo(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      AvatarWidget(
          profileImageURL: this.viewModel.profileImageURL, value: 24.0),
      SizedBox(width: 4.0),
      Text(this.viewModel.username,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 14.0))
    ]);
  }
}
