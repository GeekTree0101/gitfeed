import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gitfeed/screen/detail/detail_model.dart';
import 'package:gitfeed/screen/favorite/favorite_model.dart';
import 'package:gitfeed/widget/repository_item.dart';
import 'package:gitfeed/widget/toast.dart';
import 'package:provider/provider.dart';

class FavoriteScene extends StatefulWidget {

  // key
  FavoriteScene({Key key}) : super(key: key);

  // createState
  @override
  FavoriteState createState() => FavoriteState();
}

class FavoriteState extends State<FavoriteScene> {
  
  FToast _toast;

  @override
  void initState() {
    super.initState();
    _toast = FToast();
    _toast.init(context);
  }
  
  @override
  Widget build(BuildContext context) {
    final model = context.watch<FavoriteModel>();

    return PlatformScaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            scrollableList(context, model), 
            emptyView(model)
          ],
        ),
      ),
    );
  }

  Widget emptyView(FavoriteModel model) {
    if (!model.isEmpty) {
      return Container();
    }

    return Center(
      child: Text(
        "Your favorite repository\ndoesn't exist.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget scrollableList(BuildContext context, FavoriteModel model) {
    if (Platform.isIOS) {
      return CupertinoScrollbar(child: list(context, model));
    } else {
      return Scrollbar(child: list(context, model));
    }
  }

  Widget list(BuildContext context, FavoriteModel model) {
    return ListView.builder(
      itemCount: model.items.length,
      itemBuilder: (context, index) {
        return RepositoryItemWidget(
          hasAddButton: false,
          hasDeleteButton: true,
          viewModel: model.items[index],
          onTap: () {
            _click(context, model, model.items[index].id);
          },
          onDelete: () {
            final id = model.items[index].id;
            final result = model.deleteFavorite(id);
            
            _toast.removeCustomToast();
            _toast.showToast(
              child: GitFeedToast(viewModel: result),
              positionedToastBuilder: (context, child) => Positioned(
                child: child,
                bottom: 120.0,
                left: 24.0,
                right: 24.0,
              ),
              gravity: ToastGravity.BOTTOM,
              toastDuration: Duration(seconds: 2),
            );
          },
        );
      },
    );
  }

  void _click(BuildContext context, FavoriteModel model, int id) {
    final repo = model.getRepositoryByID(id);

    if (repo == null) {
      return;
    }

    final payload = DetailPayload(owner: repo.owner);
    Navigator.pushNamed(context, "detail", arguments: payload);
  }
}
