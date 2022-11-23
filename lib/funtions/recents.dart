import 'dart:developer';
import 'package:hive_flutter/adapters.dart';
import 'package:musicue/funtions/mostplayed.dart';
import 'package:musicue/models/db_functions/db_functions.dart';
import 'package:musicue/models/songs.dart';

class Recents {
  static final Box<Songs> songbox = getSongBox();
  static final Box<List> playlistbox = getPlaylistBox();

  static addSongtoRecents({required String songId}) async {
    log('Recent song function called');
    final List<Songs> dbsongs = songbox.values.toList().cast<Songs>();
    final List<Songs> recentSongList =
        playlistbox.get('Recent')!.toList().cast<Songs>();

    final Songs recentSong =
        dbsongs.firstWhere((song) => song.id.contains(songId));

    ///////////////////////////     for Most played     /////////////////////

    int count = recentSong.count;
    recentSong.count = count + 1;
    Mostplayed.addSongToPlaylist(songId);
    log("${recentSong.count}Recent Song Count");

    ////////////////////////////////////////////////////////////////////////

    if (recentSongList.length >= 10) {
      recentSongList.removeLast();
    }
    if (recentSongList.where((song) => song.id == recentSong.id).isEmpty) {
      recentSongList.insert(0, recentSong);
      await playlistbox.put('Recent', recentSongList);
    } else {
      recentSongList.removeWhere((song) => song.id == recentSong.id);
      recentSongList.insert(0, recentSong);
      await playlistbox.put('Recent', recentSongList);
    }
  }
}
