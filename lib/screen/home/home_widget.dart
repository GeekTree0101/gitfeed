import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:gitfeed/screen/detail/detail_model.dart';
import 'package:gitfeed/screen/home/components/home_error_widget.dart';
import 'package:gitfeed/screen/home/components/home_list_widget.dart';
import 'package:gitfeed/screen/home/components/home_loading_indicator_widget.dart';
import 'package:gitfeed/screen/home/home_model.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  // key
  HomeWidget({Key key}) : super(key: key);

  // createState
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeModel>(context, listen: false).reload();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
      builder: (context, model, child) {
        return PlatformScaffold(
            appBar: PlatformAppBar(
              backgroundColor: Colors.white,
              material: (context, platform) {
                return MaterialAppBarData(
                  title: Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),
                );
              },
              cupertino: (context, platform) => CupertinoNavigationBarData(
                title: Text("Home"),
              ),
            ),
            body: Stack(children: [
              HomeLoadingIndicatorWidget(),
              HomeErrorWidget(),
              HomeListWidget(onClick: (item) {
                final repo = model.getRepositoryByID(item.id);
                if (repo != null) {
                  final payload = new DetailPayload(owner: repo.owner);
                  Navigator.pushNamed(context, "/detail", arguments: payload);
                }
              }, onNext: () {
                model.next();
              })
            ]));
      },
    );
  }
}
