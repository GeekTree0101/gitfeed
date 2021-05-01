import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gitfeed/model/owner.dart';
import 'package:gitfeed/screen/detail/detail_model.dart';
import 'package:gitfeed/screen/favorite/favorite_model.dart';
import 'package:gitfeed/widget/avatar.dart';
import 'package:gitfeed/widget/toast.dart';
import 'package:provider/provider.dart';

class DetailScreenViewModel {
  String username;
  String profileImageURL;
  String navigationTitle;

  DetailScreenViewModel(Owner owner) {
    this.username = owner.username;
    this.profileImageURL = owner.profileImageURL;
    this.navigationTitle = owner.username + "'s profile";
  }
}

class DetailScreenWidget extends StatefulWidget {
  static const String path = "/detail";

  // key
  DetailScreenWidget({Key key}) : super(key: key);

  // createState
  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreenWidget> {
  FToast _toast;

  @override
  void initState() {
    super.initState();
    _toast = FToast();
    final obj = Provider.of<DetailModel>(context, listen: false);
    obj.reload();
    debugPrint("context: " + identityHashCode(context).toString());
    debugPrint("change notifier: " + identityHashCode(obj).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailModel>(
      builder: (context, model, child) {
        return PlatformScaffold(
            material: (context, platform) => MaterialScaffoldData(),
            cupertino: (context, platform) => CupertinoPageScaffoldData(),
            appBar: appbar(context, model),
            body: body(model));
      },
    );
  }

  Widget appbar(BuildContext context, DetailModel model) {
    return PlatformAppBar(
      title: Text(
        model.viewModel.navigationTitle,
        style: TextStyle(color: Colors.black),
      ),
      trailingActions: [
        GestureDetector(
          onTap: () {
            final result = Provider.of<FavoriteModel>(context, listen: false)
                .addFavorite(model.repo);
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
          child: Icon(
            Icons.add,
          ),
        ),
      ],
      material: (context, platform) => MaterialAppBarData(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[900])),
      cupertino: (context, platform) => CupertinoNavigationBarData(
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget body(DetailModel model) {
    return SafeArea(
      child: Center(
        child: Padding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AvatarWidget(
                  profileImageURL: model.viewModel.profileImageURL,
                  value: 80.0),
              SizedBox(height: 16.0),
              Text(model.viewModel.username,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, color: Colors.grey[800]))
            ],
          ),
          padding: EdgeInsets.all(24.0),
        ),
      ),
    );
  }
}
