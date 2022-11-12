import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/utils/utilil.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'commponents/bottomnav.dart';
import 'provider/themeprovider.dart';
import 'package:fooddelivery/firebase_options.dart';
import 'screen/authentication.dart';
import 'utils/utilil.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.removeAfter(initialization);
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 1));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

final navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeprovider =
              Provider.of<ThemeProvider>(context, listen: true);
             return GetMaterialApp(
                    navigatorKey: navigatorKey,
                    scaffoldMessengerKey: Utils.messengerKey,
                    debugShowCheckedModeBanner: false,
                    themeMode: themeprovider.themeMode,
                    theme: MyThemes.lightTheme,
                    darkTheme: MyThemes.darkTheme,
                    home: StreamBuilder<User?>(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(
                              color: AppColors.maincolor);
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text(
                            '${snapshot.error}',
                          ));
                        } else if (snapshot.hasData) {
                          return const BottomNavBar();
                        } else {
                          return const AuthPage();
                        }
                      },
                    ));
            
        },
      ),
    ]);
  }
}
