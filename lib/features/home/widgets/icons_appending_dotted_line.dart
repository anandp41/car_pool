import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import 'dotted_line.dart';

class IconsAppendingDottedLine extends StatelessWidget {
  const IconsAppendingDottedLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.radio_button_checked_outlined,
          size: 16,
          color: startLocationColor,
        ),
        DottedLine(),
        Icon(
          Icons.location_on,
          size: 22,
          color: endLocationColor,
        )
      ],
    );
  }
}
