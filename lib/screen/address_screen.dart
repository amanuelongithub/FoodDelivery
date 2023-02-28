import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddelivery/commponents/bottomnav.dart';
import 'package:fooddelivery/commponents/default_button.dart';
import 'package:fooddelivery/commponents/final.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/utils/utilil.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import '../commponents/address_info.dart';
import '../commponents/location_card.dart';
import '../provider/themeprovider.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../service/firestore.dart';
import 'package:google_maps_pick_place/google_maps_pick_place.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  String address = '';
  bool _locationSelected = false;
  late Position _currentLocation;
  late Marker _selectedLocation;
  late Circle _selectedLocationCircle;
  final geo = Geoflutterfire();
  bool _locationEnabled = false, _isLoading = true;
  late AnimationController lottieController;

  void getLocation() async {
    try {
      print("hello i am get location ");
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
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";
    const CameraPosition _initialCameraPostion =
        CameraPosition(target: LatLng(9.0167110, 38.6923718), zoom: 19);
    final Completer<GoogleMapController> _googleMapController = Completer();

    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      backgroundColor:
          isDark == "dark" ? null : Color.fromARGB(255, 231, 231, 231),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 15, bottom: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    color: isDark == "dark" ? Colors.white : Colors.black54,
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Text(
                    "Address",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9), // <-- Radius
                        ),
                        foregroundColor: Colors.black38,
                        backgroundColor: AppColors.maincolor,
                        shadowColor: Colors.transparent,
                        minimumSize: Size(100, 30)),
                    onPressed: () {
                      Get.off(() => BottomNavBar());
                    },
                    child: Text(
                      "Home",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Divider(
                color: Color.fromARGB(255, 136, 136, 136),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 2, color: AppColors.maincolor)),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      _locationEnabled
                          ? Container(
                              height: 600,
                              child: GoogleMap(
                                mapType: MapType.hybrid,
                                myLocationButtonEnabled: true,
                                mapToolbarEnabled: false,
                                myLocationEnabled: true,
                                markers: {
                                  if (_locationSelected) _selectedLocation
                                },
                                circles: {
                                  if (_locationSelected) _selectedLocationCircle
                                },
                                onTap: (pos) async {
                                  await GoogleMapsPickPlace(
                                      apiKey:
                                          'AIzaSyDxgI6qse4k0EPqH-qjaXS_P0P4TE0lt2o',
                                      getResult: (FullAddress fullAddress) {
                                        setState(() {
                                          address =
                                              fullAddress.address.toString();

                                          print(
                                              'PPPPPPPPPPPPPPPPPPPPP${fullAddress.address.toString()}');
                                          print(
                                              'PPPPPPPPPPPPPPPPPPPPP${fullAddress.position.toString()}');
                                        });
                                      });
                                  userLocation = pos.toString();
                                  setState(() {
                                    _selectedLocation = Marker(
                                        markerId: const MarkerId("Selected"),
                                        infoWindow: const InfoWindow(
                                            title: "your address is here"),
                                        position: pos,
                                        icon: BitmapDescriptor
                                            .defaultMarkerWithHue(
                                                BitmapDescriptor.hueOrange));
                                    _selectedLocationCircle = Circle(
                                      strokeColor: Colors.transparent,
                                      fillColor: Color(0x54F1B341),
                                      circleId:
                                          const CircleId("selectedCircle"),
                                      center: pos,
                                      zIndex: 1,
                                      radius: 10,
                                    );
                                    _locationSelected = true;
                                  });
                                },
                                zoomGesturesEnabled: true,
                                zoomControlsEnabled: false,
                                initialCameraPosition: _initialCameraPostion,
                                onMapCreated: (GoogleMapController controller) {
                                  _googleMapController.complete(controller);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                              color: AppColors.maincolor,
                            ))
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('user')
                    .doc(_auth.currentUser!.uid)
                    .snapshots()
                    .first, //get all data and streambuilder used as as real time
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.maincolor,
                        ),
                      );
                    }
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                        child: Text(
                      "user not found",
                      style:
                          TextStyle(color: Color.fromARGB(184, 138, 138, 138)),
                    ));
                  }
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Unabel to get user data",
                      style:
                          TextStyle(color: Color.fromARGB(184, 138, 138, 138)),
                    ));
                  } else if (snapshot.hasData) {
                    return AddressInfoCard(
                      snap: snapshot.data,
                     
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              // Spacer(),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('user')
                      .doc(_auth.currentUser!.uid)
                      .snapshots()
                      .first,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.maincolor,
                          ),
                        );
                      }
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                          child: Text(
                        "user not found",
                        style: TextStyle(
                            color: Color.fromARGB(184, 138, 138, 138)),
                      ));
                    }
                    if (snapshot.hasError) {
                      return Center(
                          child: Text(
                        "Unabel to get user data",
                        style: TextStyle(
                            color: Color.fromARGB(184, 138, 138, 138)),
                      ));
                    } else if (snapshot.hasData) {
                      return Align(
                        child: DefaultButton(
                            text: "Make Order",
                            press: () {
                              if (!_locationSelected) {
                                Utils.showSnackBar("Please select a location");
                                return;
                              } else {
                                // makeOrder(_selectedLocation.position.latitude,
                                //     _selectedLocation.position.longitude, isDark);
                                Get.off(() => FinalOrder(
                                      snapusername: snapshot.data,
                                      latit:
                                          _selectedLocation.position.latitude,
                                      long:
                                          _selectedLocation.position.longitude,
                                    ));
                              }
                            }),
                      );
                    } else {
                      return Container();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
