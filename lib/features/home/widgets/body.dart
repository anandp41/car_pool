//Essentially the whole body including the stack which is in background in home screen
import 'dart:developer';

import 'package:car_pool/controllers/locations_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_directions/flutter_map_directions.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/colors.dart';
import '../../../core/radii.dart';
import 'destination_panel.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var addressesSection =
      // clearAddressBar()
      typedInAddressBar();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        GetBuilder<LocationsController>(
          init: LocationsController(),
          initState: (_) {},
          builder: (controller) {
            return FlutterMap(
              options: MapOptions(
                bounds:
                    controller.canShowDirections() ? controller.bounds : null,

                center: controller.canShowDirections()
                    ? null
                    : const LatLng(
                        8.5241, 76.9366), // Coordinates for Thiruvananthapuram
                zoom: 18.0,
              ),
              nonRotatedChildren: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.anand.car_pool',
                ),
                if (controller.canShowDirections())
                  DirectionsLayer(coordinates: controller.finalCoordinates),
                MarkerLayer()
              ],
            );
          },
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.518,
          minChildSize: 0.17,
          maxChildSize: 0.518,
          builder: (context, scrollController) => DestinationPanel(
            maxPanelHeight: screenHeight * 0.518,
            controller: scrollController,
          ),
        )
      ],
    );
  }

  static Widget typedInAddressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            //The address bar
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(radiusCircular15),
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                      color: Color.fromRGBO(0, 0, 0, 0.14))
                ]),
            child: TextField(
              onTap: () {},
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  prefixIconColor: Colors.black,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8),
                    child: Icon(
                      Icons.search,
                    ),
                  ),
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  hintText: "Where would you go?",
                  hintStyle: TextStyle(
                      fontFamily: "Poppins", color: addressBarHintColor)),
            ),
          )
        ],
      ),
    );
  }

  static Widget clearAddressBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Container(
            //The address bar
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(radiusCircular20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                      color: Color.fromRGBO(0, 0, 0, 0.14))
                ]),
            child: TextField(
              onTap: () {},
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  prefixIconColor: Colors.black,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8),
                    child: Icon(
                      Icons.search,
                    ),
                  ),
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  hintText: "Where would you go?",
                  hintStyle: TextStyle(
                      fontFamily: "Poppins", color: addressBarHintColor)),
            ),
          ),
        ),
      ],
    );
  }
}
