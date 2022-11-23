import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musicue/screens/favorate_screen.dart';
import 'package:musicue/screens/homeScreen.dart';
import 'package:musicue/screens/library.dart';
import 'package:musicue/screens/screen_playlist.dart';
import 'package:musicue/screens/searchScreen.dart';
import 'package:musicue/screens/settings.dart';
import 'package:musicue/widgets/dbox.dart';

// class CustomDrawer extends StatelessWidget {
//   CustomDrawer({
//     Key? key,

//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     returny
//   }
// }

Widget DrawerFunction({required IconData leadingicon, required titletext}) {
  return ListTile(
    leading: Icon(
      leadingicon,
      color: Colors.black,
      size: 20,
    ),
    title: Text(
      titletext,
      style: const TextStyle(fontSize: 15, color: Colors.black),
    ),
    trailing: Icon(
      Icons.arrow_forward_ios_outlined,
      color: Colors.grey,
      size: 20,
    ),
  );
}
