import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gitfeed/app_dependency.dart';
import 'package:gitfeed/screen/detail/detail_model.dart';
import 'package:gitfeed/screen/detail/detail_screen_widget.dart';
import 'package:gitfeed/screen/home/home_model.dart';
import 'package:gitfeed/screen/main/main_widget.dart';
import 'package:gitfeed/screen/profile/profile_model.dart';
import 'package:provider/provider.dart';

class AppRouter {

  AppDependency _appDependency;
  
  AppRouter(AppDependency appDependency) {
    this._appDependency = appDependency;
  }

  Map<String, Widget Function(BuildContext)> routes() {

    return {
      '/': (ctx) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (ctx) => new HomeModel(_appDependency.repositoryWorker)
            ),
            ChangeNotifierProvider(
              create: (ctx) => new ProfileModel(_appDependency.authWorker)
            )
          ],
          builder: (context, child) => new MainWidget(),
        ),
      '/detail': (ctx) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => new DetailModel(),
          )
        ],
        builder: (context, child) {
          final payload = ModalRoute.of(context).settings.arguments as DetailPayload;
          final model = Provider.of<DetailModel>(context, listen: false);
          model.setRepository(payload.repo);
          return DetailScreenWidget();
        }
      )
    };
  }

}