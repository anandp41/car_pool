import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';

class PastLocationsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const PastLocationsTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        backgroundColor: activeGray,
        radius: 16,
        child: Icon(
          Icons.location_on,
          color: Colors.white,
          size: 20,
        ),
      ),
      title: Text(title),
      titleTextStyle: pastLocationTileTitleTS,
      subtitle: Text(subtitle),
      subtitleTextStyle: pastLocationTileSubtitleTS,
    );
  }
}
