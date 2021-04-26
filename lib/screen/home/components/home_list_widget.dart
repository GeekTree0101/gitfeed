import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gitfeed/screen/home/home_model.dart';
import 'package:gitfeed/widget/repository_item.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeListWidget extends StatelessWidget {

  final RefreshController refreshController;
  final Function() onRefresh;
  final Function() onNext;
  final Function(RepositoryItemViewModel viewModel) onClick;

  HomeListWidget({this.refreshController, this.onRefresh, this.onNext, this.onClick});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeModel>();

    return NotificationListener(
      child: scrollableList(model),
      onNotification: (notification) {
        if (model.shouldBatch(notification)) {
          onNext();
        }
      },
    );
  }

  Widget scrollableList(HomeModel model) {
    if (Platform.isIOS) {
      return CupertinoScrollbar(child: refreshableList(model));
    } else {
      return Scrollbar(child: refreshableList(model));
    }
  }

  Widget refreshableList(HomeModel model) {
    return SmartRefresher(
      controller: refreshController,
      header: ClassicHeader(
        idleText: "drag more",
        completeText: "success!",
        failedText: "failed :[",
        refreshingText: "refreshing...",
      ),
      enablePullDown: true,
      enablePullUp: false,
      onRefresh: () => onRefresh(),
      child: list(model),
    );
  }

  Widget list(HomeModel model) {
    return ListView.builder(
      itemCount: model.items.length,
      itemBuilder: (context, index) {
        return RepositoryItemWidget(
          viewModel: model.items[index],
          onTap: () {
            onClick(model.items[index]);
          },
        );
      },
    );
  }
}
