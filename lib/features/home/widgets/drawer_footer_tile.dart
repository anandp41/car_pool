import 'package:flutter/material.dart';

import '../../../core/textstyles.dart';

class DrawerFooterTile extends StatelessWidget {
  final String title;

  const DrawerFooterTile({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: drawerFooterTS,
    );
  }
}
