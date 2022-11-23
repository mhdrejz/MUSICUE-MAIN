import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musicue/screens/favorate_screen.dart';
import 'package:musicue/screens/homeScreen.dart';
import 'package:musicue/screens/library.dart';
import 'package:musicue/screens/playingScreen.dart';
import 'package:musicue/screens/searchScreen.dart';
import 'package:musicue/screens/settings.dart';
import 'package:musicue/widgets/dbox.dart';

class CustomnavBarFunction extends StatelessWidget {
  CustomnavBarFunction({
    Key? key,
  }) : super(key: key);
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.grey.shade100,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  height: 55,
                  width: 70,
                  child: dbox(
                      Child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                  )),
                ),
              ),
              label: "home"),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  height: 55,
                  width: 70,
                  child: dbox(
                      Child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ScreenSearch(audioPlayer: audioPlayer),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  )),
                ),
              ),
              label: "play"),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  height: 55,
                  width: 70,
                  child: dbox(
                    Child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScreenLibrary(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.library_music_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              label: "library"),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  height: 55,
                  width: 70,
                  child: dbox(
                    Child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Settings(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              label: "profile")
        ]);
  }
}
