// import 'package:flutter/material.dart';

// import 'package:musicue/screens/homeScreen.dart';
// import 'package:musicue/screens/library.dart';
// import 'package:musicue/screens/settings.dart';
// import 'package:musicue/widgets/appBar.dart';
// import 'package:musicue/widgets/dbox.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// bool? SWITCHVALUE;

// class ScreenNavigation extends StatefulWidget {
//   const ScreenNavigation({super.key});

//   @override
//   State<ScreenNavigation> createState() => ScreenNavigationState();
// }

// class ScreenNavigationState extends State<ScreenNavigation> {
  
//   String greeting() {
//     var hour = DateTime.now().hour;
//     if (hour < 12) {
//       return 'Good Morning !';
//     }
//     if (hour < 16) {
//       return 'Good Afternoon !';
//     }
//     if (hour < 19) {
//       return 'Good Evening !';
//     }

//     return 'Good Night !';
//   }

//   @override
//   void initState() {
//     checkNotification();
//     super.initState();
//   }

//   Future<void> checkNotification() async {
//     final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
//     SWITCHVALUE = sharedPrefs.getBool(NOTIFICATION);
//     SWITCHVALUE = SWITCHVALUE ??= true;
//   }

//   final _bottomNavBar = const <BottomNavigationBarItem>[
//     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//     BottomNavigationBarItem(icon: Icon(Icons.queue_music), label: 'Playlist'),
//     BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
//   ];

//   final List<Widget> _screens = <Widget>[
//     const HomeScreen(),
//     ScreenLibrary(),
//     const Settings(),
//   ];

//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading:dbox(Child: IconButton(onPressed:(){} , icon:const Icon(Icons.menu))),
//         title: Text(greeting()),
//         centerTitle: true,
//         actions: [
//           dbox(Child: IconButton(onPressed: (){}, icon:const Icon(Icons.graphic_eq_rounded)))
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
//           child: _screens[_selectedIndex],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: (value) {
//           setState(() {
//             _selectedIndex = value;
//           });
//         },
//         currentIndex: _selectedIndex,
//         elevation: 0,
//         backgroundColor: const Color(0xFF1B262C),
//         iconSize: 30,
//         selectedItemColor: const Color(0xFFBBE1FA),
//         unselectedItemColor: const Color(0xFF0F4C75),
//         items: _bottomNavBar,
//       ),
//     );
//   }
// }
