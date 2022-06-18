import 'package:location/location.dart';

class LocationGetter {
  double? lat;
  double? long;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    lat = locationData.latitude;
    long = locationData.longitude;
  }

  void setLatLng(String latitude, String longitude) {
    lat = double.parse(latitude);
    long = double.parse(longitude);
  }
}
