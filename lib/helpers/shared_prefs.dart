import 'dart:convert';

import '../main.dart';

List getCurrentLatLngFromSharedPrefs() {
  return [prefs.getDouble('latitude')!, prefs.getDouble('longitude')!];
}

String getCurrentAddressFromSharedPrefs() {
  return prefs.getString('current-address')!;
}

List getTripLatLngFromSharedPrefs(String type) {
  List sourceLocationList = json.decode(prefs.getString('source')!)['location'];
  List destinationLocationList =
      json.decode(prefs.getString('destination')!)['location'];
  List source = [sourceLocationList[0], sourceLocationList[1]];
  List destination = [destinationLocationList[0], destinationLocationList[1]];

  if (type == 'source') {
    return source;
  } else {
    return destination;
  }
}

String getSourceAndDestinationPlaceText(String type) {
  String sourceAddress = json.decode(prefs.getString('source')!)['name'];
  String destinationAddress =
      json.decode(prefs.getString('destination')!)['name'];

  if (type == 'source') {
    return sourceAddress;
  } else {
    return destinationAddress;
  }
}
