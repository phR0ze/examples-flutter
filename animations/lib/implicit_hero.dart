import 'package:flutter/material.dart';
import 'const.dart';

class ImageHero extends StatelessWidget {
  final int index;
  final String image;
  final VoidCallback? onTap;

  const ImageHero({
    required this.image,
    required this.index,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Hero(
        tag: image + index.toString(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(image, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}

class ImplicitHero extends StatelessWidget {
  const ImplicitHero({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.all(20),
            children: List.generate(10, (index) {
              return ImageHero(
                index: index,
                image: Const.assetFreeImage,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (context) {
                      return Container(
                        color: Colors.black,
                        child: ImageHero(
                          index: index,
                          image: Const.assetFreeImage,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      );
                    },
                  ));
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
