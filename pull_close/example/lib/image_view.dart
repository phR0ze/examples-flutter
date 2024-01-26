import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final int index;
  final String image;
  final VoidCallback? onTap;

  const ImageView({
    required this.image,
    required this.index,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Image.asset(image, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
