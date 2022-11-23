import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicue/funtions/alert_function.dart';
import 'package:musicue/models/db_functions/db_functions.dart';
import 'package:musicue/models/songs.dart';
import 'package:musicue/widgets/createdPlaylist.dart';
import 'package:musicue/widgets/dbox.dart';

class ScreenPlaylist extends StatelessWidget {
  ScreenPlaylist({super.key});

  final Box<List> playlistBox = getPlaylistBox();
  final Box<Songs> songBox = getSongBox();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
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
                    Text('P L A Y L I S T'),
                    Container(
                      height: 60,
                      width: 60,
                      child: dbox(
                          Child: IconButton(
                              onPressed: () {
                                showCreatingPlaylistDialoge(context: context);
                              },
                              icon: Icon(Icons.add))),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: playlistBox.listenable(),
                      builder: (context, value, child) {
                        List keys = playlistBox.keys.toList();
                        keys.removeWhere((key) => key == 'Favourites');
                        keys.removeWhere((key) => key == 'Recent');
                        keys.removeWhere((key) => key == 'Most Played');
                        return (keys.isEmpty)
                            ? const Center(
                                child: Text('No Created Playlist..'),
                              )
                            : GridView.builder(
                                itemCount: keys.length,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 1.25,
                                ),
                                itemBuilder: (context, index) {
                                  final String playlistName = keys[index];

                                  final List<Songs> songList = playlistBox
                                      .get(playlistName)!
                                      .toList()
                                      .cast<Songs>();

                                  final int songListlength = songList.length;

                                  return CreatedPlaylist(
                                    playlistImage: 'assets/images/sample 8.jpg',
                                    playlistName: playlistName,
                                    playlistSongNum: '$songListlength Songs',
                                  );
                                },
                              );
                      },
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
