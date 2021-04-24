import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gitfeed/screen/home/home_model.dart';
import 'package:gitfeed/widget/repository_item.dart';
import 'package:provider/provider.dart';

class HomeListWidget extends StatelessWidget {
  final Function() onNext;
  final Function(RepositoryItemViewModel viewModel) onClick;

  HomeListWidget({this.onNext, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
      builder: (context, model, child) {
        return NotificationListener(
          child: scrollableList(model),
          onNotification: (notification) {
            if (model.shouldBatch(notification)) {
              onNext();
            }
          },
        );
      },
    );
  }

  Widget scrollableList(HomeModel model) {
    if (Platform.isIOS) {
      return CupertinoScrollbar(child: list(model));
    } else {
      return Scrollbar(child: list(model));
    }
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
