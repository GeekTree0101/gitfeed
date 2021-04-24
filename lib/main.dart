import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:gitfeed/screen/detail/detail_model.dart';
import 'package:gitfeed/screen/detail/detail_screen_widget.dart';
import 'package:gitfeed/screen/home/home_model.dart';
import 'package:gitfeed/screen/home/home_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: "Gitfeed",
      material: (context, target) => MaterialAppData(),
      cupertino: (context, target) => CupertinoAppData(),
      routes: <String, WidgetBuilder>{
        '/': (ctx) => ChangeNotifierProvider(
          create: (ctx) => new HomeModel(),
          builder: (context, child) {
            return HomeWidget();
          }
        ),
        '/detail': (ctx) => ChangeNotifierProvider(
          create: (ctx) => new DetailModel(),
          builder: (context, child) {
            final payload = ModalRoute.of(context).settings.arguments as DetailPayload;
            final model = Provider.of<DetailModel>(context, listen: false);
            model.setOwner(payload.owner);
            return DetailScreenWidget();
          }
        )
      },
    );
  }
}
