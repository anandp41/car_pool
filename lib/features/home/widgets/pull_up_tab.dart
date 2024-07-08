import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../core/radii.dart';

class PullUpTab extends StatelessWidget {
  const PullUpTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // the pull up tab
      width: 34,
      height: 5,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(radiusCircular20),
      ),
      child: const Divider(
        thickness: 5,
        color: tinyDividerColor,
      ),
    );
  }
}
