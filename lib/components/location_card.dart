/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fooddelivery/utils/utilil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../utils/colors.dart';

class LocationCard extends StatefulWidget {
  const LocationCard({Key? key}) : super(key: key);

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  bool _locationSelected = false;
  double _selectedRadius = 0.5;
  late Position _currentLocation;
  late Marker _selectedLocation;
  late Circle _selectedLocationCircle;
  // String? placeName;
  bool _locationEnabled = false, _isLoading = true;

  // void getPlaceName() async {
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(9.0167110, 38.6923718);
  //   placeName = placemarks;
  // }

  void getLocation() async {
    try {
      _currentLocation = await determinePosition();

      setState(() {
        _locationEnabled = true;
        _isLoading = false;
      });
    } catch (e) {
      try {
        _currentLocation = (await Geolocator.getLastKnownPosition())!;
        print(
          "Using last known location to load feed",
        );
        setState(() {
          _locationEnabled = true;
          userLocation = _currentLocation.toString();
        });
      } catch (e) {
        print(
          "Please enable location services.",
        );
      }
    }
  }

  @override
  void initState() {
    getLocation();
    super.initState();
    // getPlaceName();
  }

  /*
  static const double _defLat = 9.0186;
  static const double _defLong = 38.6971;
  List<Marker> markers = [];

  bool mapToggle = false;
  var currentLocation;

  void initState() {
    super.initState();

    Geolocator.getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;

        mapToggle = true;
      });
      
      markers.add(Marker(
          markerId: MarkerId('myMarkerId'),
          draggable: true,

          // onTap: ,
          position: LatLng(
              // 45.51563, -122.677433,
              9.0167110,
              38.6923718
              // currentLocation.latitude,
              // currentLocation.longitude
              //
              )));
    });
  }

  getMarkerLocation(LatLng tapedPoint) {
    // print('hereeeeeeeeeeeeeeee');
    print(tapedPoint);
    setState(() {
      userLocation = tapedPoint;

      markers = [];
      markers.add(Marker(
          markerId: MarkerId(tapedPoint.toString()),
          position: tapedPoint,
          draggable: true,
          onDragEnd: (drugEndPosition) {
            print(drugEndPosition);
          }));
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    const CameraPosition _initialCameraPostion = CameraPosition(
        target: LatLng(9.01611042424233, 38.76187135931119), zoom: 20);
    final Completer<GoogleMapController> _googleMapController = Completer();

  }
}
*/