import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fooddelivery/components/edit_card.dart';
import 'package:fooddelivery/screen/address_screen.dart';
import 'package:fooddelivery/screen/cart_screen.dart';
import 'package:fooddelivery/screen/detaile_screen.dart';
import 'package:fooddelivery/screen/edit_account.dart';
import 'package:fooddelivery/screen/feed_screen.dart';
import 'package:fooddelivery/screen/order_screen.dart';
import 'package:fooddelivery/screen/setting_screen.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/bottomnav.dart';
import 'provider/themeprovider.dart';
import 'package:fooddelivery/firebase_options.dart';
import 'screen/authentication.dart';
import 'utils/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.remove();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  runApp(MyApp(
    preferences: preferences,
  ));
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 1));
}

class MyApp extends StatefulWidget {
  final SharedPreferences? preferences;
  const MyApp({Key? key, this.preferences}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

final navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(
            prefThem: widget.preferences!.getBool('isDark') ?? false),
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
            initialRoute: '/',
            getPages: [
              GetPage(name: "/", page: () => getRoute()),
              GetPage(name: "/home", page: () => const BottomNavBar()),
              GetPage(name: "/order", page: () => OrderScreen()),
              GetPage(name: "/cart", page: () => CartScreen()),
              GetPage(name: "/setting", page: () => const  SettingScreen()),
              GetPage(name: "/address", page: () => const  AddressScreen()),
              GetPage(name: "/editaccount", page: () => const EditAccount()),
              GetPage(name: "/Auth", page: () => const AuthPage()),
              // GetPage(name: "/detaile", page: ()=> DetailPage()),
            ],
          );
        },
      ),
    ]);
  }

  Widget getRoute() {
    late Widget route = AuthPage();
    return route = StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(color: AppColors.maincolor);
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
    );
  }
}
