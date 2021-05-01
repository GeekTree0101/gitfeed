import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:gitfeed/app_dependency.dart';
import 'package:gitfeed/router.dart';
import 'package:gitfeed/screen/favorite/favorite_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {

  final appDependency = AppDependency();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => new FavoriteModel()
        )
      ],
      child: PlatformApp(
        title: "Gitfeed",
        material: (context, target) => MaterialAppData(),
        cupertino: (context, target) => CupertinoAppData(),
        routes: AppRouter(appDependency).routes()
      )
    );
  }
}
