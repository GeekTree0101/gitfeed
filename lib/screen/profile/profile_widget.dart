import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:gitfeed/screen/profile/components/profile_content_view.dart';
import 'package:gitfeed/screen/profile/profile_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileWidget extends StatefulWidget {
  // key
  ProfileWidget({Key key}) : super(key: key);

  // createState
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfileWidget> {

  final _controller = RefreshController();

  @override
  void initState() {
    super.initState();
    initialLoad();
  }

  initialLoad() async {
    await Provider.of<ProfileModel>(context, listen: false).reload();
  }

  refresh(ProfileModel model) async {
    try {
      await model.reload();
      _controller.refreshCompleted();
    } catch (error) {
      _controller.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProfileModel>();

    return PlatformScaffold(
      body: SafeArea(
        child: SmartRefresher(
          controller: _controller,
          header: ClassicHeader(
            idleText: "drag more",
            completeText: "success!",
            failedText: "failed :[",
            refreshingText: "refreshing...",
          ),
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: () => refresh(model),
          child: Stack(
            children: [statusView(model), loading(model)],
          ),
        ),
      ),
    );
  }

  Widget statusView(ProfileModel model) {
    if (model.isLoading) {
      return Container();
    } else if (model.isError) {
      return error();
    } else {
      return content();
    }
  }

  Widget loading(ProfileModel model) {
    return AnimatedOpacity(
      opacity: model.isLoading ? 1.0 : 0.0,
      duration: Duration(milliseconds: 200),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(
              animating: true,
            ),
            SizedBox(height: 8.0),
            Text(
              "Loading...",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
            )
          ],
        ),
      ),
    );
  }

  Widget error() {
    return Center(
      child: Text(
        "unknown error",
        style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
      ),
    );
  }

  Widget content() {
    return ProfileContentView();
  }
}
