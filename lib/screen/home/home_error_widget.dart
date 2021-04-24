
import 'package:flutter/material.dart';
import 'package:gitfeed/screen/home/home_model.dart';
import 'package:provider/provider.dart';

class HomeErrorWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Consumer<HomeModel>(
      builder: (context, model, child) {
        return Center(
          child: content(model)
        );
      },
    );
  }

  Widget content(HomeModel model) {

    if (model.isError) {
      return Text("api error");
    } else {
      return Container();
    }
  }
}