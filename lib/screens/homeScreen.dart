import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicue/models/db_functions/db_functions.dart';
import 'package:musicue/models/songs.dart';
import 'package:musicue/screens/favorate_screen.dart';
import 'package:musicue/screens/library.dart';
import 'package:musicue/screens/mostplayed.dart';
import 'package:musicue/screens/screen_playlist.dart';
import 'package:musicue/screens/searchScreen.dart';
import 'package:musicue/screens/settings.dart';
import 'package:musicue/widgets/customCards.dart';
import 'package:musicue/widgets/dbox.dart';
import 'package:musicue/widgets/drawer.dart';
import 'package:musicue/widgets/navBarFunction.dart';
import 'package:musicue/widgets/songList_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box<Songs> songBox = getSongBox();
  Box<List> playlistBox = getPlaylistBox();

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  GlobalKey<ScaffoldState> _globalkey = GlobalKey<ScaffoldState>();

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning !';
    }
    if (hour < 16) {
      return 'Good Afternoon !';
    }
    if (hour < 19) {
      return 'Good Evening !';
    }

    return 'Good Night !';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _globalkey,
      drawer:
          // CustomDrawer(ctx: context)
          Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.grey.shade200,
        child: Column(
          // padding: EdgeInsets.zero,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 68,
                        backgroundImage: AssetImage(
                          'assets/images/sample 8.jpg',
                        ),
                      ),
                    ],
                  ),
                ),
                dbox(
                  Child: InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScreenPlaylist(),
                    )),
                    child: DrawerFunction(
                      leadingicon: Icons.playlist_play_rounded,
                      titletext: 'P L A Y L I S T',
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                dbox(
                  Child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ScreenSearch(audioPlayer: audioPlayer)),
                      );
                    },
                    child: DrawerFunction(
                      leadingicon: Icons.search,
                      titletext: 'S E A R C H',
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                dbox(
                  Child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenLibrary()),
                      );
                    },
                    child: DrawerFunction(
                      leadingicon: Icons.playlist_play_rounded,
                      titletext: 'R E C E N T L Y  P L A Y',
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                dbox(
                  Child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FavScreen()),
                      );
                    },
                    child: DrawerFunction(
                        leadingicon: Icons.favorite_outline_outlined,
                        titletext: 'L I K E D  S O N G S'),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                // InkWell(
                //   child: DrawerFunction(
                //       leadingicon: Icons.equalizer_rounded, titletext: 'Equalizer'),
                // ),
                dbox(
                  Child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Settings()),
                      );
                    },
                    child: DrawerFunction(
                        leadingicon: Icons.settings,
                        titletext: 'S E T T I N G S'),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Version',
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.6),
                      fontSize: 20,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '0.0.1',
                  style: TextStyle(
                      color: Colors.grey.withOpacity(1),
                      fontSize: 15,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomnavBarFunction(),
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  child: dbox(
                      Child: IconButton(
                          onPressed: () {
                            _globalkey.currentState!.openDrawer();
                          },
                          icon: Icon(Icons.menu))),
                ),
                Text(
                  greeting(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3),
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: dbox(
                      Child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.graphic_eq_sharp))),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    // margin: const EdgeInsets.symmetric(vertical: 3.0),
                    height: screenHeight * 0.20,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                            // onTap: Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavScreen(playlistName: playlistName),)),
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => (FavScreen()),
                                )),
                            child:
                                customCard1(libraryname: 'F A V O U R I T E')),
                        SizedBox(width: 8),
                        GestureDetector(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ScreenPlaylist(),
                                )),
                            child: customCard2(libraryname: 'P L A Y L I S T')),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ScreenMostPlayed(),
                                )),
                            child:
                                customCard3(libraryname: 'M O S T P L A Y E D'))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Text(
                          'S O N G S',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 3,
                  ),
                  ValueListenableBuilder(
                    valueListenable: songBox.listenable(),
                    builder: (BuildContext context, boxSongs, _) {
                      List<Songs> songList =
                          songBox.values.toList().cast<Songs>();
                      return (songList.isEmpty)
                          ? const Text("No Songs Found")
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return SongListTile(
                                  onPressed: () {
                                    log(songList.length.toString());
                                    // showPlaylistModalSheet(
                                    //   context: context,
                                    //   // screenHeight: screenHeight,
                                    //   song: songList[index],
                                    // );
                                  },
                                  songList: songList,
                                  index: index,
                                  audioPlayer: audioPlayer,
                                );
                              },
                              itemCount: songBox.length,
                            );
                    },
                  ),
                ],
              ),
            ),
          ]),
        )),
      ),
    );
  }
}
