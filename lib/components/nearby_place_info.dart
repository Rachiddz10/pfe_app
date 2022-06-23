class NearbyPlaceInfo {
  final int id;
  final double distance;

  NearbyPlaceInfo({required this.id, required this.distance});

  factory NearbyPlaceInfo.fromJson(int idJson, double distanceJson) {
    NearbyPlaceInfo nearbyPlaceInfo = NearbyPlaceInfo(
      id: idJson,
      distance: distanceJson,
    );
    return nearbyPlaceInfo;
  }
}