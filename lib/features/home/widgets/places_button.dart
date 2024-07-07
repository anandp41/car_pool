//Class of the pre-set destinations Home, Office and Apartment

import 'package:flutter/material.dart';

import '../../../core/colors.dart';

class PlacesButton extends StatelessWidget {
  final String name;

  const PlacesButton({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
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
            style: const TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                color: disabledGrey,
                fontSize: 14),
          ),
          const SizedBox(
            width: 34,
          )
        ],
      ),
    );
  }
}
