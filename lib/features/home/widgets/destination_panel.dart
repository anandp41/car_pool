import 'dart:developer';

import 'package:car_pool/common/custom_snackbar.dart';
import 'package:car_pool/features/home/widgets/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import '../../../controllers/locations_controller.dart';
import '../../../core/colors.dart';
import '../../../core/radii.dart';
import 'dotted_line.dart';
import 'past_location_tile.dart';
import 'places_button.dart';

class DestinationPanel extends StatelessWidget {
  final ScrollController controller;
  final double maxPanelHeight;

  DestinationPanel({
    super.key,
    required this.controller,
    required this.maxPanelHeight,
  });

  @override
  Widget build(BuildContext context) {
    final locationsController = Get.put(LocationsController());
    const placeButtons = [
      PlacesButton(name: "Home"),
      PlacesButton(name: "Office"),
      PlacesButton(name: "Apartment")
    ];
    final debouncer1 = Debouncer();
    final debouncer2 = Debouncer();
    return Container(
      constraints: BoxConstraints(maxHeight: maxPanelHeight),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: SizedBox(
              height: 55,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 12,
                ),
                itemCount: placeButtons.length,
                itemBuilder: (context, index) => placeButtons[index],
                padding: const EdgeInsets.all(6),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0,
                    blurRadius: 15,
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: radiusCircular20,
                  topRight: radiusCircular20,
                ),
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: controller,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      Container(
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
                      ),
                      const SizedBox(
                        // space after pull up tab
                        height: 12,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.radio_button_checked_outlined,
                                size: 16,
                                color: Color.fromRGBO(47, 76, 212, 1),
                              ),
                              DottedLine(),
                              Icon(
                                Icons.location_on,
                                size: 22,
                                color: Color.fromRGBO(0, 209, 21, 1),
                              )
                            ],
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  // The current location address bar
                                  margin: const EdgeInsets.only(left: 8),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(radiusCircular20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                        color: Color.fromRGBO(0, 0, 0, 0.14),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    onChanged: (value) async {
                                      if (value.isNotEmpty) {
                                        debouncer1.run(() async {
                                          //debouncer of 2 seconds
                                          try {
                                            List<Location> locations =
                                                await locationFromAddress(
                                                    value);
                                            locationsController
                                                .addStartCoordinate(
                                                    locations[0]);
                                          } catch (e) {
                                            showCustomSnackBar(
                                                message: e.toString());
                                          }
                                        });
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 12,
                                      ),
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      alignLabelWithHint: true,
                                      hintText: "Start location",
                                      hintStyle: TextStyle(
                                        fontFamily: "Poppins",
                                        color: addressBarHintColor,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  // The destination address bar
                                  margin: const EdgeInsets.only(left: 8),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(radiusCircular20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                        color: Color.fromRGBO(0, 0, 0, 0.14),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    onChanged: (value) async {
                                      if (value.isNotEmpty) {
                                        debouncer2.run(() async {
                                          //debouncer of 2 seconds

                                          try {
                                            List<Location> locations =
                                                await locationFromAddress(
                                                    value);
                                            locationsController
                                                .addEndCoordinate(locations[0]);
                                          } catch (e) {
                                            showCustomSnackBar(
                                                message: e.toString());
                                          }
                                        });
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 12,
                                      ),
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      alignLabelWithHint: true,
                                      hintText: "Destination",
                                      hintStyle: TextStyle(
                                        fontFamily: "Poppins",
                                        color: addressBarHintColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 27,
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: pastLocationTiles.length,
                        separatorBuilder: (context, index) => const Divider(
                          color: dividerColor,
                          indent: 50,
                        ),
                        itemBuilder: (context, index) =>
                            pastLocationTiles[index],
                      ),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final pastLocationTiles = [
    const PastLocationsTile(
      title: 'Work',
      subtitle: '67, Grand Central Pkwy, New York',
    ),
    const PastLocationsTile(
      title: 'Home',
      subtitle: '67, Grand Central Pkwy, New York',
    ),
    const PastLocationsTile(
      title: '67, Grand Central Pkwy, New York',
      subtitle: '67, Grand Central Pkwy, New York',
    ),
    const PastLocationsTile(
      title: '67, Grand Central Pkwy, New York',
      subtitle: '67, Grand Central Pkwy, New York',
    ),
    const PastLocationsTile(
      title: '67, Grand Central Pkwy, New York',
      subtitle: '67, Grand Central Pkwy, New York',
    ),
  ];
}
