import 'package:flutter/material.dart';
import 'package:gitfeed/screen/home/home_widget.dart';
import 'package:gitfeed/widget/color.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gitfeed',
      theme: ThemeData(
        primarySwatch: ColorSystem.gray700,
      ),
      home: HomeWidget(),
    );
  }
}
