import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String profileImageURL;
  final double value;

  AvatarWidget({this.profileImageURL, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.value,
      height: this.value,
      decoration: avatarDecoration(),
    );
  }

  BoxDecoration avatarDecoration() {
    if (this.profileImageURL == null) {
      return BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black26,
          border: Border.all(color: Colors.grey[300], width: 0.5));
    } else {
      return BoxDecoration(
          image:
              DecorationImage(image: NetworkImage(this.profileImageURL ?? "")),
          shape: BoxShape.circle,
          color: Colors.black26,
          border: Border.all(color: Colors.grey[300], width: 0.5));
    }
  }
}
