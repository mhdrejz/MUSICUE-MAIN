import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicue/models/db_functions/db_functions.dart';
import 'package:musicue/models/songs.dart';
import 'package:musicue/widgets/dbox.dart';
import 'package:musicue/widgets/songList_tile.dart';

class ScreenMostPlayed extends StatelessWidget {
  ScreenMostPlayed({super.key});

  final String playlistName = 'Most Played';

  final Box<List> playlistBox = getPlaylistBox();
  final Box<Songs> songBox = getSongBox();
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
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
                  Text('M O S T P L A Y E D'),
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
              ValueListenableBuilder(
                valueListenable: playlistBox.listenable(),
                builder:
                    (BuildContext context, Box<List> value, Widget? child) {
                  List<Songs> songList =
                      playlistBox.get('Most Played')!.toList().cast<Songs>();
                  return (songList.isEmpty)
                      ? const Center(
                          child: Text('No Songs Found'),
                        )
                      : Expanded(
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
        )),
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
