import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Location {
  double? lat;
  double? long;

  Future<void> getCurrentLocation() async {
    if (await Permission.speech.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
    }
    // You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
    }
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      long = position.longitude;
      lat = position.latitude;
    }
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      //Permission.storage,
    ].request();
    //print(statuses[Permission.location]);
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    long = position.longitude;
    lat = position.latitude;
  }
}
