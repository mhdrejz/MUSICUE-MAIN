import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicue/models/songs.dart';
import 'package:musicue/screens/favorate_screen.dart';
import 'package:musicue/screens/homeScreen.dart';
import 'package:musicue/screens/playingScreen.dart';
import 'package:musicue/screens/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(SongsAdapter());
  }
  await Hive.openBox<Songs>("Songs");
  await Hive.openBox<List>("Playlist");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Musicue',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
