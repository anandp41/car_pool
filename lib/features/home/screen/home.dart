import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/colors.dart';
import '../../../core/radii.dart';
import '../widgets/body.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Body(),
      backgroundColor: Colors.white,
      extendBody: true,
      bottomNavigationBar: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  spreadRadius: 0,
                  blurRadius: 14)
            ],
            borderRadius: BorderRadius.only(
                topLeft: radiusCircular20, topRight: radiusCircular20)),
        child: BottomNavigationBar(
            iconSize: 26,
            currentIndex: 1,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.directions_car,
                    color: inactiveIconColor,
                  ),
                ),
                label: "Rides",
              ),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      // Icons.trip_origin,
                      Iconsax.tag_2_copy, color: activeIconColor,
                    ),
                  ),
                  label: "Trips"),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.group_outlined,
                      color: inactiveIconColor,
                    ),
                  ),
                  label: "Whiz +")
            ]),
      ),
    );
  }
}
