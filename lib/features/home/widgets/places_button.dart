//Class of the pre-set destinations Home, Office and Apartment

import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';

class PlacesButton extends StatelessWidget {
  final String name;

  const PlacesButton({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: disabledGrey,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 6, right: 6.0),
            child: Icon(
              Icons.location_on,
              color: disabledGrey,
              size: 26,
            ),
          ),
          Text(
            name,
            style: placesButtonNameTS,
          ),
          const SizedBox(
            width: 34,
          )
        ],
      ),
    );
  }
}
