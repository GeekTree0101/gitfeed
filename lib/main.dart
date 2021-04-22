import 'package:flutter/material.dart';
import 'package:gitfeed/screen/home/home_widget.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gitfeed',
      theme: ThemeData(
        primaryColor: Colors.grey[400],
      ),
      home: HomeWidget(),
    );
  }
}
