import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_directions/flutter_map_directions.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class LocationsController extends GetxController {
  List<DirectionCoordinate?> coordinates = [null, null];
  List<DirectionCoordinate> finalCoordinates = [
    DirectionCoordinate(-1.0, -1.0),
    DirectionCoordinate(-1.0, -1.0)
  ];
  var corner1 = const LatLng(0, 0);
  var corner2 = const LatLng(0, 0);
  var bounds = LatLngBounds(const LatLng(0, 0), const LatLng(0, 0));
  void addStartCoordinate(Location location) {
    var coordinate = DirectionCoordinate(location.latitude, location.longitude);
    coordinates[0] = coordinate;
    if (checkIfBothCoordinatesExist()) {
      for (int i = 0; i <= 1; i++) {
        finalCoordinates[i] = coordinates[i]!;
      }

      copyCorners();
      update();
    } else {
      clearFinalCoordinates();
    }
  }

  void addEndCoordinate(Location location) {
    var coordinate = DirectionCoordinate(location.latitude, location.longitude);
    coordinates[1] = coordinate;
    if (checkIfBothCoordinatesExist()) {
      for (int i = 0; i <= 1; i++) {
        finalCoordinates[i] = coordinates[i]!;
      }
      copyCorners();
      update();
    } else {
      clearFinalCoordinates();
    }
  }

  void clearFinalCoordinates() {
    finalCoordinates.fillRange(0, 2, DirectionCoordinate(-1.0, -1.0));
  }

  void copyCorners() {
    corner1 =
        LatLng(finalCoordinates[0].latitude, finalCoordinates[0].longitude);
    corner2 =
        LatLng(finalCoordinates[0].latitude, finalCoordinates[0].longitude);
    bounds = LatLngBounds(corner1, corner2);
  }

  bool checkIfBothCoordinatesExist() {
    if (coordinates[0] != null && coordinates[1] != null) {
      return true;
    } else {
      return false;
    }
  }

  bool canShowDirections() {
    for (var item in finalCoordinates) {
      if (item.latitude == -1.0 && item.longitude == -1.0) {
        return false;
      }
    }
    return true;
  }
}
