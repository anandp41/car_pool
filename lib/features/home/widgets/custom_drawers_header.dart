import 'package:flutter/material.dart';

import '../../../core/textstyles.dart';

class CustomDrawersHeader extends StatelessWidget {
  const CustomDrawersHeader({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
              onPressed: () {
                _scaffoldKey.currentState?.closeDrawer();
              },
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              label: const Text(
                "Back",
                style: customDrawerBackButtonTS,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
            child: Row(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/person.png',
                      width: 50,
                      height: 50,
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.blue),
                              color: Colors.white,
                              shape: BoxShape.circle),
                          child: Image.asset(
                            'assets/images/building.png',
                            fit: BoxFit.contain,
                            height: 12,
                            width: 12,
                          ),
                        ))
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 26.0),
                  child: Text(
                    "Sithara Thomas",
                    style: customDrawerUserNameTS,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
