import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicue/models/db_functions/db_functions.dart';
import 'package:musicue/models/songs.dart';
import 'package:musicue/screens/favorate_screen.dart';
import 'package:musicue/screens/mostplayed.dart';
import 'package:musicue/screens/playingScreen.dart';
import 'package:musicue/screens/screen_playlist.dart';
import 'package:musicue/screens/searchScreen.dart';
import 'package:musicue/widgets/customCards.dart';
import 'package:musicue/widgets/dbox.dart';
import 'package:musicue/widgets/navBarFunction.dart';
import 'package:musicue/widgets/songList_tile.dart';

class ScreenLibrary extends StatelessWidget {
  ScreenLibrary({super.key});
  final String playlistName = 'Recent';
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  Box<List> playlistBox = getPlaylistBox();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: CustomnavBarFunction(),
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      child: dbox(
                          Child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios))),
                    ),
                    Text('L I B R A R Y'),
                    Container(
                      height: 60,
                      width: 60,
                      child: dbox(
                          Child: IconButton(
                              onPressed: () {
                                showClearAlert(
                                    context: context, key: playlistName);
                              },
                              icon: Icon(Icons.clear_all_rounded))),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      height: screenHeight * 0.22,
                      width: double.infinity,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => FavScreen(),
                                  )),
                              child: customCard1(
                                  libraryname: 'F A V O U R I T E')),
                          SizedBox(width: 8),
                          GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ScreenPlaylist(),
                                  )),
                              child:
                                  customCard2(libraryname: 'P L A Y L I S T')),
                          SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ScreenMostPlayed(),
                                  )),
                              child: customCard3(
                                  libraryname: 'M O S T P L A Y E D')),
                        ],
                      ),
                    ),
                    const Text(
                      'RECENTLY PLAYED',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ValueListenableBuilder(
                      valueListenable: playlistBox.listenable(),
                      builder: (BuildContext context, Box<List> value,
                          Widget? child) {
                        List<Songs> songList =
                            value.get("Recent")!.toList().cast<Songs>();
                        return (songList.isEmpty)
                            ? const Center(
                                child: Text('No Songs Found'),
                              )
                            : SingleChildScrollView(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: songList.length,
                                  itemBuilder: (context, index) {
                                    return SongListTile(
                                      onPressed: () {},
                                      songList: songList,
                                      index: index,
                                      audioPlayer: audioPlayer,
                                    );
                                  },
                                ),
                              );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showClearAlert({required BuildContext context, required String key}) {
    final playlistBox = getPlaylistBox();

    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Clear $playlistName',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(
              'Do you want to clear $playlistName',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  List<Songs> dbSongs = songBox.values.toList().cast<Songs>();

                  await songBox.clear();

                  for (var item in dbSongs) {
                    Songs song = Songs(
                      id: item.id,
                      title: item.title,
                      artist: item.artist,
                      uri: item.uri,
                      count: 0,
                    );
                    await songBox.put(song.id, song);
                  }
                  await playlistBox.put(playlistName, []);
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
