import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicue/models/db_functions/db_functions.dart';
import 'package:musicue/models/songs.dart';
import 'package:musicue/screens/playingScreen.dart';
import 'package:musicue/screens/searchScreen.dart';
import 'package:musicue/widgets/dbox.dart';
import 'package:musicue/widgets/navBarFunction.dart';
import 'package:musicue/widgets/songList_tile.dart';

class FavScreen extends StatelessWidget {
  FavScreen({
    super.key,
  });
  final String playlistName = 'Favourites';

  final Box<List> playlistBox = getPlaylistBox();
  final Box<Songs> songBox = getSongBox();

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: dbox(
      //         Child: const Icon(
      //       Icons.arrow_back,
      //       color: Colors.black,
      //     )),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.grey.shade300,
      //   elevation: 0,
      //   title: Text(
      //     playlistName,
      //     style: const TextStyle(
      //       color: Colors.black,
      //       letterSpacing: 3,
      //       fontSize: 26,
      //       fontWeight: FontWeight.w300,
      //     ),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 15),
      //       child: IconButton(
      //         icon: dbox(
      //             Child: const Icon(
      //           Icons.menu,
      //           color: Colors.black,
      //         )),
      //         onPressed: () {
      //           // showClearAlert(context: context, key: playlistName);
      //         },
      //       ),
      //     ),
      //   ],
      // ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
          child: Column(
            children: [
              Row(
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
                  Text('F A V O U R I T E S'),
                  Container(
                    height: 60,
                    width: 60,
                    child: dbox(
                        Child: IconButton(
                            onPressed: () {
                              showClearAlert(
                                  context: context, key: playlistName);
                            },
                            icon: Icon(Icons.clear_all))),
                  )
                ],
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: playlistBox.listenable(),
                  builder:
                      (BuildContext context, Box<List> value, Widget? child) {
                    List<Songs> songList =
                        playlistBox.get("Favourites")!.toList().cast<Songs>();
                    return (songList.isEmpty)
                        ? const Center(
                            child: Text('No Songs Found'),
                          )
                        : ListView.builder(
                            itemCount: songList.length,
                            itemBuilder: (context, index) {
                              return SongListTile(
                                onPressed: () {
                                  // showPlaylistModalSheet(
                                  //   context: context,
                                  //   screenHeight: screenHeight,
                                  //   song: songList[index],
                                  // );
                                },
                                songList: songList,
                                index: index,
                                audioPlayer: audioPlayer,
                              );
                            },
                          );
                  },
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
