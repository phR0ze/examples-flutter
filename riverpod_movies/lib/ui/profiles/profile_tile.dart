import 'package:flutter/material.dart';
import '../../const.dart';
import '../../data/models/exports.dart';

class ProfileTile extends StatelessWidget {
  final Profile profile;

  const ProfileTile({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(profile.name),
        ),
        child: GestureDetector(
            child: Image.asset(Const.assetImagePlaceholder,
                fit: BoxFit.cover, cacheWidth: Const.imageCacheQuality),
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (_) => FileScreen(index, entries)));
            }));
  }
}
