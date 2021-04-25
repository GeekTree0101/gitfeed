
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:gitfeed/screen/home/home_widget.dart';
import 'package:gitfeed/screen/profile/profile_widget.dart';
import 'package:ionicons/ionicons.dart';

class MainWidget extends StatelessWidget {

  final Color activeColor = Colors.grey[900];
  final Color inactiveColor = Colors.grey[500];

  @override
  Widget build(BuildContext context) {

    return PlatformScaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  Widget appBar() {
    
    return PlatformAppBar(
        material: (context, platform) => MaterialAppBarData(
          title: navigationBarTitle(),
          backgroundColor: Colors.white
        ),
        cupertino: (context, platform) => CupertinoNavigationBarData(
          title: navigationBarTitle()
        ),
      );
  }

  Widget body() {

    return PlatformTabScaffold(
      materialTabs: (context, platform) => MaterialNavBarData(
        items: tabItems(),
        selectedItemColor: activeColor,
        unselectedItemColor: inactiveColor,
      ),
      cupertinoTabs: (context, platform) => CupertinoTabBarData(
        items: tabItems(),
        activeColor: activeColor,
        inactiveColor: inactiveColor
      ),
      tabController: PlatformTabController(
        android: MaterialTabControllerData(
          initialIndex: 0
        ),
        ios: CupertinoTabControllerData(
          initialIndex: 0
        ) 
      ),
      bodyBuilder: (context, index) {
        switch (index) {
          case 0:
            return HomeWidget();
          case 1:
            return ProfileWidget();
          default:
            UnsupportedError("undefined case");
        }
      },
    );
  }

  Widget navigationBarTitle() {
    return Text(
      "Gitfeed",
      style: TextStyle(color: Colors.grey[900]),
    );
  }

  List<BottomNavigationBarItem> tabItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Ionicons.home_outline, color: inactiveColor),
        activeIcon: Icon(Ionicons.home, color: activeColor),
        label: "home"
      ),
      BottomNavigationBarItem(
        icon: Icon(Ionicons.person_outline, color: inactiveColor),
        activeIcon: Icon(Ionicons.person, color: activeColor),
        label: "my profile"
      )
    ];
  }
}