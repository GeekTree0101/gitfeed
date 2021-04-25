import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:gitfeed/model/repository.dart';
import 'package:gitfeed/widget/avatar.dart';
import 'package:ionicons/ionicons.dart';

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
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
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
        child: content(context),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              userInfo(context),
              SizedBox(width: 4.0),
              addOrRemoteButton()
            ],
          )
        ],
      ),
      padding: EdgeInsets.all(12.0),
    );
  }

  Widget addOrRemoteButton() {

    final padding = EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0, bottom: 12.0);

    return PlatformButton(
      material: (context, platform) => MaterialRaisedButtonData(
        color: Colors.blue[600],
        padding: padding,
        child: Center(
          child: Row(
            children: [
              Icon(Ionicons.add, color: Colors.white, size: 24.0),
              SizedBox(width: 2.0),
              Text("Add",
                  style: TextStyle(fontSize: 16.0, color: Colors.white))
            ],
          ),
        )
      ),
      cupertino: (context, platform) => CupertinoButtonData(
        color: Colors.blue[600],
        padding: padding,
        child: Center(
          child: Row(
            children: [
              Icon(Ionicons.add, color: Colors.white, size: 24.0),
              SizedBox(width: 2.0),
              Text("Add",
                  style: TextStyle(fontSize: 16.0, color: Colors.white))
            ],
          ),
        )
      ),
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
