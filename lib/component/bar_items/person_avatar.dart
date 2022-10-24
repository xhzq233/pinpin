/// pinpin - person_avatar
/// Created by xhz on 24/10/2022

import 'package:flutter/material.dart';
import 'package:pinpin/component/stateful_button/pp_image_button.dart';

class PersonAvatar extends StatelessWidget {
  const PersonAvatar({
    Key? key,
    required this.url,
    this.size = 56.0,
  }) : super(key: key);

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: url.hashCode,
      child: PPImageButton.fromImage(
        Image.network(
          url,
          width: size,
          height: size,
          fit: BoxFit.scaleDown,
        ),
        onPressed: () {},
        padding: 1,
      ),
    );
  }
}
