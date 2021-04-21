import 'package:flutter/material.dart';
import 'package:gitfeed/model/repository.dart';
import 'package:gitfeed/widget/avatar.dart';
import 'package:gitfeed/widget/color.dart';

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

  final RepositoryItemViewModel viewModel;

  // constructor
  RepositoryItemWidget({
    this.viewModel
  });

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      child: content(context),
      padding: EdgeInsets.all(16.0),
    );
  }

  Widget content(BuildContext context) {

    return Column(
      children: [
        repositoryInfo(context),
        SizedBox(height: 4.0),
        userInfo(context),
      ],
    );
  }

  Widget repositoryInfo(BuildContext context) {

    return Row(
      children: [
        Text(
          this.viewModel.title, 
          style: TextStyle(
            color: ColorSystem.gray900,
            fontWeight: FontWeight.bold,
            fontSize: 24.0
          )
        ),
        SizedBox(
          height: 8.0
        ),
        Text(
          this.viewModel.description,
          style: TextStyle(
            color: ColorSystem.gray700,
            fontWeight: FontWeight.normal,
            fontSize: 16.0
          )
        )
      ]
    );
  }

  Widget userInfo(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AvatarWidget(
          profileImageURL: this.viewModel.profileImageURL, 
          value: 48.0
        ),
        SizedBox(width: 4.0),
        Text(
          this.viewModel.username,
          style: TextStyle(
            color: ColorSystem.gray600,
            fontWeight: FontWeight.normal,
            fontSize: 14.0
          )
        )
      ]
    );
  }
}