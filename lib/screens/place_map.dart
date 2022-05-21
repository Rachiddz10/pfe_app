import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pfe_app/core/location_service.dart';
import '../core/geo_location.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaceMap extends StatefulWidget {
  static const String id = 'PlaceMap';
  final Location? location;
  final Location? sitePosition;

  const PlaceMap({required this.sitePosition, required this.location, Key? key}) : super(key: key);

  @override
  State<PlaceMap> createState() => PlaceMapState();
}

class PlaceMapState extends State<PlaceMap> {
  final Completer<GoogleMapController> _controller = Completer();
  double? lati;
  double? longi;
  double? siteLatitude;
  double? siteLongitude;
  String? distance;
  bool taped = false;
  static int markerID = 1;

  final Set<Marker> _markers = <Marker>{};
  final Set<Polygon> _polygons = <Polygon>{};
  final Set<Polyline> _polylines = <Polyline>{};
  List<LatLng> polygonLatLngs = <LatLng>[];

  //int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  CameraPosition getPosition() {
    return CameraPosition(
        target: LatLng(siteLatitude!, siteLongitude!),
        zoom: 19.151926040649414);
  }

  CameraPosition getCameraPosition() {
    return CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(siteLatitude!, siteLongitude!),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
  }

  @override
  void initState() {
    super.initState();
    lati = widget.location!.lat;
    longi = widget.location!.long;
    siteLatitude = widget.sitePosition!.lat;
    siteLongitude = widget.sitePosition!.long;
    //_setMarker(const LatLng(37.42796133580664, -122.085749655962));
    _setMarker(LatLng(siteLatitude!, siteLongitude!),);
  }

  @override
  dispose() {
    super.dispose();
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('marker$markerID'),
        position: point,
      ));
      markerID++;
    });
  }

  /*void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(Polygon(
      polygonId: PolygonId(polygonIdVal),
      points: polygonLatLngs,
      strokeWidth: 3,
      fillColor: Colors.transparent,
    ));
  }*/

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.mapOfPlace),
        centerTitle: true,
      ),
      body: GoogleMap(
        markers: _markers,
        polygons: _polygons,
        polylines: _polylines,
        mapType: MapType.normal,
        initialCameraPosition: getCameraPosition(),
        //initialCameraPosition: getPosition(),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var directions = await LocationService().getDirectionWithLatLng(
            LatLng(lati!, longi!),
            LatLng(siteLatitude!, siteLongitude!),
          );
          distance = directions['distance'];
          taped = true;
          _goToPlace(
            directions['start_location']['lat'],
            directions['start_location']['lng'],
            directions['bounds_ne'],
            directions['bounds_sw'],
          );
          _setPolyline(directions['polyline_decoded']);
        },
        label: taped ? Text('${AppLocalizations.of(context)!.itineraryWithDistance} $distance') : Text(AppLocalizations.of(context)!.itinerary),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Future<void> _goToPlace(double lat, double lng, Map<String, dynamic> boundsNe,
      Map<String, dynamic> boundsSw) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(lat, lng),
        zoom: 12,
      ),
    ));
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
          northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
        ),
        25,
      ),
    );
    _setMarker(LatLng(lat, lng));
  }
}
