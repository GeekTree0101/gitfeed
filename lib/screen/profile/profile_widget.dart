import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:gitfeed/screen/profile/components/profile_content_view.dart';
import 'package:gitfeed/screen/profile/profile_model.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatefulWidget {
  // key
  ProfileWidget({Key key}) : super(key: key);

  // createState
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfileWidget> {

  @override 
  void initState() {
    super.initState();
    Provider.of<ProfileModel>(context, listen: false).reload();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProfileModel>();

    return PlatformScaffold(
      body: body(model),
    );
  }

  Widget body(ProfileModel model) {
    if (model.isLoading) {
      return loading();
    } else if (model.isError) {
      return error();
    } else {
      return content();
    }
  }

  Widget loading() {
    return Center(
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
