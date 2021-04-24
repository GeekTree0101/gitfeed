import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gitfeed/screen/home/home_model.dart';
import 'package:provider/provider.dart';

class HomeLoadingIndicatorWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
      builder: (context, model, child) {
        return Center(
          child: AnimatedOpacity(
            opacity: model.isFetching ? 1.0 : 0.0,
            duration: Duration(milliseconds: 200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(
                  animating: model.isFetching,
                ),
                SizedBox(height: 8.0),
                Text(
                  "Loading...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[700]
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}