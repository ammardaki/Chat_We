import 'package:chat_we/screens/splach_screen.dart';
// import 'package:chat_we/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//global object for accessing device screen
late Size mq;
void main() {
   WidgetsFlutterBinding.ensureInitialized();

  //enter full-screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  //for setting orientation to portrait only
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    _initializeFirebase();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatPlus',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 1.0,
            titleTextStyle: GoogleFonts.lora(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 19,
            ),
            backgroundColor: Colors.white,
          ),
          iconTheme: const IconThemeData(color: Colors.black)),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
