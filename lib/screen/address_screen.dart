import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddelivery/components/bottomnav.dart';
import 'package:fooddelivery/components/default_button.dart';
import 'package:fooddelivery/components/final.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/utils/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import '../components/address_info.dart';
import '../components/location_card.dart';
import '../provider/themeprovider.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import '../service/firestore.dart';

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

  getAddressfromGeocode(LatLng? pos) async {
    // final value = await placemarkFromCoordinates(52.2165157, 6.9437819);
    if (pos != null) {
      final value = await placemarkFromCoordinates(pos.latitude, pos.longitude);
      placeMarker =
          '${value.first.street}, ${value.first.name}, ${value.first.administrativeArea}';
    } else {
      final value = await placemarkFromCoordinates(52.2165157, 6.9437819);
      placeMarker = value.first.street.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    getAddressfromGeocode(null);
    print('########################################');
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
                                mapType: MapType.satellite,
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
                                  userLocation = pos.toString();
                                  getAddressfromGeocode(pos);
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: FutureBuilder(
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
                  style: TextStyle(color: Color.fromARGB(184, 138, 138, 138)),
                ));
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Unabel to get user data",
                  style: TextStyle(color: Color.fromARGB(184, 138, 138, 138)),
                ));
              } else if (snapshot.hasData) {
                return Align(
                  child: DefaultButton(
                      text: "Pay with PayPal",
                      width: 300,
                      press: () async {
                        var request = BraintreeDropInRequest(
                          tokenizationKey: 'sandbox_q7636k9g_4xmxrwr2m7qy6bmj',
                          collectDeviceData: true,
                          paypalRequest: BraintreePayPalRequest(
                              amount: '10.00', displayName: 'yonatan elias'),
                          cardEnabled: true,
                        );

                        BraintreeDropInResult? result =
                            await BraintreeDropIn.start(request);

                        if (result != null) {
                          print('*****************************************');
                          print(result.paymentMethodNonce.description);
                          print('*****************************************');
                          print(result.paymentMethodNonce.nonce);
                        }

                        // if (!_locationSelected) {
                        //   Utils.showSnackBar("Please select a location");
                        //   return;
                        // } else {
                        //   // makeOrder(_selectedLocation.position.latitude,
                        //   //     _selectedLocation.position.longitude, isDark);
                        //   Get.off(() => FinalOrder(
                        //         snapusername: snapshot.data,
                        //         latit:
                        //             _selectedLocation.position.latitude,
                        //         long:
                        //             _selectedLocation.position.longitude,
                        //       ));
                        // }
                      }),
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}
