import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gitfeed/screen/detail/detail_model.dart';
import 'package:gitfeed/screen/favorite/favorite_model.dart';
import 'package:gitfeed/screen/home/components/home_error_widget.dart';
import 'package:gitfeed/screen/home/components/home_list_widget.dart';
import 'package:gitfeed/screen/home/components/home_loading_indicator_widget.dart';
import 'package:gitfeed/screen/home/home_model.dart';
import 'package:gitfeed/widget/toast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeWidget extends StatefulWidget {
  // key
  HomeWidget({Key key}) : super(key: key);

  // createState
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeWidget> {
  FToast _toast;
  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _toast = FToast();
    _toast.init(context);
    initialLoad();
  }

  initialLoad() {
    Provider.of<HomeModel>(context, listen: false).reload();
  }

  refresh(HomeModel model) async {
    try {
      await model.reload();
      _refreshController.refreshCompleted();
    } catch (error) {
      _refreshController.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeModel>();

    return PlatformScaffold(
      body: SafeArea(
        child: Stack(children: [
          HomeLoadingIndicatorWidget(),
          HomeErrorWidget(),
          HomeListWidget(
              refreshController: _refreshController,
              onRefresh: () {
                refresh(model);
              },
              onAdd: (item) async {
                final repo = model.getRepositoryByID(item.id);
                if (repo != null) {
                  final result = Provider.of<FavoriteModel>(context, listen: false).addFavorite(repo);
                  
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
                }
              },
              onClick: (item) {
                final repo = model.getRepositoryByID(item.id);
                if (repo != null) {
                  final payload = new DetailPayload(repo: repo);
                  Navigator.pushNamed(context, "/detail", arguments: payload);
                }
              },
              onNext: () {
                model.next();
              })
        ]),
      ),
    );
  }
}
