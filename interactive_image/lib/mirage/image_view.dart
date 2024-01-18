import 'package:flutter/material.dart';
import '../const.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage(Const.assetFreeImage),
    );
  }
}
