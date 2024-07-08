import 'package:flutter/material.dart';

import 'places_button.dart';

class PreSetFrequentPlaceButtons extends StatelessWidget {
  const PreSetFrequentPlaceButtons({
    super.key,
    required this.placeButtons,
  });

  final List<PlacesButton> placeButtons;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
