import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/colors.dart';
import 'custom_drawers_header.dart';
import 'drawer_footer_tile.dart';
import 'drawer_tile.dart';

class CustomDrawerHome extends StatelessWidget {
  const CustomDrawerHome({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      child: Container(
        decoration: const BoxDecoration(
          color: driverDark,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDrawersHeader(scaffoldKey: _scaffoldKey),
            const DrawerTile(
              title: 'Ride History',
              icon: Icons.speed,
            ),
            const DrawerTile(icon: Iconsax.tag_2_copy, title: 'Trips'),
            const DrawerTile(icon: Icons.card_giftcard, title: 'Whiz+'),
            const DrawerTile(icon: Icons.blinds, title: 'Payments'),
            const DrawerTile(icon: Iconsax.cpu_setting_copy, title: 'Settings'),
            const DrawerTile(icon: Icons.person_2_outlined, title: 'Profile'),
            const DrawerTile(icon: Icons.exit_to_app, title: 'Sign out'),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawerFooterTile(
                    title: 'Help',
                  ),
                  DrawerFooterTile(title: 'FAQ'),
                  DrawerFooterTile(title: 'Privacy Policy'),
                  DrawerFooterTile(title: 'Terms & Conditions')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
