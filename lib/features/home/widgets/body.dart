//Essentially the whole body including the stack which is in background in home screen

import 'package:car_pool/controllers/locations_controller.dart';
import 'package:car_pool/core/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_directions/flutter_map_directions.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/colors.dart';
import '../../../core/radii.dart';
import '../../../core/textstyles.dart';
import 'destination_panel.dart';
import 'places_button.dart';
import 'preset_frequent_place_buttons.dart';
import 'pull_up_tab.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required this.screenHeight,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final double screenHeight;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool firstTouch = true;
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
                  urlTemplate: tileLayerUrlTemplate,
                  userAgentPackageName: userAgentPackageName,
                ),
                if (controller.canShowDirections())
                  DirectionsLayer(coordinates: controller.finalCoordinates),
                if (controller.canShowDirections())
                  MarkerLayer(markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: controller.corner1,
                      builder: (ctx) => Icon(
                        Icons.location_on,
                        color: startLocationColor,
                        size: 40.0,
                      ),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: controller.corner2,
                      builder: (ctx) => Icon(
                        Icons.location_on,
                        color: endLocationColor,
                        size: 40.0,
                      ),
                    ),
                  ])
              ],
            );
          },
        ),
        Positioned(
            top: 60,
            left: 20,
            child: IconButton(
                onPressed: () {
                  widget._scaffoldKey.currentState?.openDrawer();
                },
                icon: Container(
                  decoration: const ShapeDecoration(
                      shape: CircleBorder(
                          side: BorderSide(width: 1, color: Colors.black))),
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                ))),
        if (!firstTouch)
          DraggableScrollableSheet(
            initialChildSize: 0.518,
            minChildSize: 0.17,
            maxChildSize: 0.518,
            builder: (context, scrollController) => DestinationPanel(
              maxPanelHeight: screenHeight * 0.518,
              controller: scrollController,
            ),
          )
        else
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.1,
            maxChildSize: 0.3,
            builder: (context, scrollController) =>
                clearAddressBar(controller: scrollController),
          )
      ],
    );
  }

//This is the first panel that will be shown. On tapping the textfield the panel changes as is in the design
  Widget clearAddressBar({required ScrollController controller}) {
    const placeButtons = [
      PlacesButton(name: "Home"),
      PlacesButton(name: "Office"),
      PlacesButton(name: "Apartment")
    ];
    return Column(
      children: [
        PreSetFrequentPlaceButtons(placeButtons: placeButtons),
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
                    PullUpTab(),
                    const SizedBox(
                      // space after pull up tab
                      height: 12,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: Container(
                            //The address bar
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(radiusCircular20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                      color: Color.fromRGBO(0, 0, 0, 0.14))
                                ]),
                            child: TextField(
                              onTap: () {
                                setState(() {
                                  firstTouch = false;
                                });
                              },
                              decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 12),
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
                                  hintStyle: homeAddressBarHintTS),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 27,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
