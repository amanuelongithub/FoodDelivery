import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

class LottieDialog extends StatefulWidget {
  const LottieDialog({Key? key}) : super(key: key);

  @override
  State<LottieDialog> createState() => _LottieDialogState();
}

class _LottieDialogState extends State<LottieDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController lottieController;

  @override
  void initState() {
    super.initState();

    lottieController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    lottieController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          'assets/json/-done-task.json',
          repeat: false,
          controller: lottieController,
          onLoaded: (comopsition) {
            lottieController.duration = comopsition.duration;
            // lottieController.forward();
          },
          height: 120,
          width: 120,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            "Enjoy Your Order",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
          ),
        )
      ],
    );
  }
}

final firstanim = 1.0;
final secondanim = 2.0;
String? userLocation;
bool checkIntheCart = true;

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error(
        'Location services are turned off\nPlease enable location services');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Please enable location services to continue');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error('Please enable location services to continue');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
}

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String content) {
    final snackbar = SnackBar(
        duration: const Duration(milliseconds: 900), content: Text(content));

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
