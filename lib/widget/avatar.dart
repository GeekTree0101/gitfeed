
import 'package:flutter/material.dart';
import 'package:gitfeed/widget/color.dart';

class AvatarWidget extends StatelessWidget {

  final String profileImageURL;
  final double value;

  AvatarWidget({
    this.profileImageURL,
    this.value
  });

  @override
  Widget build(BuildContext context) {

    return Container(
          width: this.value,
          height: this.value,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                this.profileImageURL
              )
            ),
            shape: BoxShape.circle,
            color: ColorSystem.gray100
          ),
        );
  }
}