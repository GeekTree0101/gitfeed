import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:gitfeed/model/repository.dart';
import 'package:gitfeed/widget/avatar.dart';
import 'package:http/http.dart';
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
  final Function() onAdd;
  final Function() onDelete;
  final RepositoryItemViewModel viewModel;
  bool hasAddButton = false;
  bool hasDeleteButton = false;

  // constructor
  RepositoryItemWidget({this.viewModel, this.onAdd, this.onDelete, this.onTap, this.hasAddButton, this.hasDeleteButton});

  @override
  Widget build(BuildContext context) {

    if (hasDeleteButton) {
      return SwipeActionCell(
        key: ObjectKey(this),
        backgroundColor: Colors.transparent,
        child: touchableContent(context),
        trailingActions: [
          SwipeAction(
            backgroundRadius: 24.0,
            onTap: (_) {
              onDelete();
            },
            title: "Delete"
          )
        ],
      );
    }

    return touchableContent(context);
  }

  Widget touchableContent(BuildContext context) {
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
              addButton()
            ],
          )
        ],
      ),
      padding: EdgeInsets.all(12.0),
    );
  }

  Widget addButton() {
    
    if (!hasAddButton) {
      return Container();
    }

    final padding =
        EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 8.0);

    return PlatformButton(
      color: Colors.blue[600],
      disabledColor: Colors.grey[600],
      onPressed: () {
        onAdd();
      },
      padding: padding,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Ionicons.add, color: Colors.white, size: 16.0),
            SizedBox(width: 2.0),
            Text("Add", style: TextStyle(fontSize: 14.0, color: Colors.white))
          ],
        ),
      ),
      material: (context, platform) => MaterialRaisedButtonData(),
      cupertino: (context, platform) => CupertinoButtonData(minSize: 0.0),
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
          profileImageURL: this.viewModel.profileImageURL, value: 32.0),
      SizedBox(width: 8.0),
      Text(this.viewModel.username,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 16.0))
    ]);
  }
}
