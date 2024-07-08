import 'package:flutter/material.dart';

import '../../../core/textstyles.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  const DrawerTile({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: drawerTileTitleTS,
      ),
    );
  }
}
