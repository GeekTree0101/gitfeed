import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:gitfeed/model/owner.dart';
import 'package:gitfeed/screen/detail/detail_model.dart';
import 'package:gitfeed/widget/avatar.dart';
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
  @override
  void initState() {
    super.initState();
    Provider.of<DetailModel>(context, listen: false).reload();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailModel>(
      builder: (context, model, child) {
        return PlatformScaffold(
            material: (context, platform) => MaterialScaffoldData(),
            cupertino: (context, platform) => CupertinoPageScaffoldData(),
            appBar: appbar(model),
            body: body(model));
      },
    );
  }

  Widget appbar(DetailModel model) {
    final title = Text(
      model.viewModel.navigationTitle,
      style: TextStyle(color: Colors.black),
    );

    return PlatformAppBar(
      material: (context, platform) => MaterialAppBarData(title: title),
      cupertino: (context, platform) =>
          CupertinoNavigationBarData(title: title),
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
