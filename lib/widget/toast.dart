
import 'package:flutter/material.dart';

class GitFeedToastViewModel {
  final String message;
  final bool isSuccess;

  GitFeedToastViewModel({@required this.message, @required this.isSuccess});
}

class GitFeedToast extends StatelessWidget {

  final GitFeedToastViewModel viewModel;

  GitFeedToast({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: viewModel.isSuccess ? Colors.blue[800] : Colors.red[800],
          borderRadius: BorderRadius.all(Radius.circular(8.0))
        ),
        child: Text(
          viewModel.message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white
          ),
        ),
      );
  }
}