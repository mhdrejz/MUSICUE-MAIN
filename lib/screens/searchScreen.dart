import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicue/funtions/alert_function.dart';
import 'package:musicue/models/db_functions/db_functions.dart';
import 'package:musicue/models/songs.dart';
import 'package:musicue/widgets/dbox.dart';
import 'package:musicue/widgets/navBarFunction.dart';
import 'package:musicue/widgets/search_widget.dart';
import 'package:musicue/widgets/songList_tile.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key, required this.audioPlayer});
  final AssetsAudioPlayer audioPlayer;

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  final TextEditingController _searchController = TextEditingController();
  Box<Songs> songBox = getSongBox();
  List<Songs>? dbSongs;
  List<Songs>? searchedSongs;

  @override
  void initState() {
    super.initState();
    dbSongs = songBox.values.toList().cast<Songs>();
    searchedSongs = List<Songs>.from(dbSongs!).toList().cast<Songs>();
  }

  searchSongfomDb(String searchSong) {
    setState(() {
      searchedSongs = dbSongs!
          .where((song) =>
              song.title.toLowerCase().contains(searchSong.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      bottomNavigationBar: CustomnavBarFunction(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 20.0,
            right: 20,
          ),
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
                  Text('S E A R C H  F O R  I T'),
                  Container(
                    height: 60,
                    width: 60,
                    child: dbox(
                        Child: IconButton(
                            onPressed: () {}, icon: Icon(Icons.clear_all))),
                  )
                ],
              ),
              SearchField(
                validator: (value) {
                  return null;
                },
                textController: _searchController,
                hintText: 'WHAT ARE YOU LOOKING FOR',
                icon: Icons.search,
                onChanged: (value) {
                  searchSongfomDb(value);
                },
              ),
              Expanded(
                child: (searchedSongs!.isEmpty)
                    ? const Center(
                        child: Text('No Songs Found'),
                      )
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: searchedSongs!.length,
                        itemBuilder: (ctx, index) {
                          return SongListTile(
                            onPressed: () {
                              showPlaylistModalSheet(
                                  context: context,
                                  screenHeight: screenHeight,
                                  song: dbSongs![index]);
                            },
                            songList: searchedSongs!,
                            index: index,
                            audioPlayer: widget.audioPlayer,
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
}
