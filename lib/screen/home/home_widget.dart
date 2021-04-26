import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:gitfeed/screen/detail/detail_model.dart';
import 'package:gitfeed/screen/home/components/home_error_widget.dart';
import 'package:gitfeed/screen/home/components/home_list_widget.dart';
import 'package:gitfeed/screen/home/components/home_loading_indicator_widget.dart';
import 'package:gitfeed/screen/home/home_model.dart';
import 'package:ionicons/ionicons.dart';
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
  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
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
              onClick: (item) {
                final repo = model.getRepositoryByID(item.id);
                if (repo != null) {
                  final payload = new DetailPayload(owner: repo.owner);
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
