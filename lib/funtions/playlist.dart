import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicue/models/db_functions/db_functions.dart';
import 'package:musicue/models/songs.dart';

class UserPlaylist {
  static final Box<List> playlistBox = getPlaylistBox();
  static final Box<Songs> songBox = getSongBox();

  static addSongToPlaylist({
    required BuildContext context,
    required String songId,
    required String playlistName,
  }) async {
    List<Songs> playlistSongs =
        playlistBox.get(playlistName)!.toList().cast<Songs>();

    List<Songs> allSongs = songBox.values.toList().cast<Songs>();
    Songs song = allSongs.firstWhere((element) => element.id.contains(songId));

    if (playlistSongs.contains(song)) {
      showPlaylistSnackbar(
          context: context,
          songName: song.title,
          message: 'Already Exist in the playlist');
    } else {
      playlistSongs.add(song);
      await playlistBox.put(playlistName, playlistSongs);
      showPlaylistSnackbar(
          context: context,
          songName: song.title,
          message: 'Added to the Playlist');
    }
  }

  static deleteFromPlaylist({
    required BuildContext context,
    required String playlistName,
    required String songId,
  }) async {
    List<Songs> playlistSongs =
        playlistBox.get(playlistName)!.toList().cast<Songs>();
    List<Songs> allSongs = songBox.values.toList().cast<Songs>();

    Songs song = allSongs.firstWhere((element) => element.id.contains(songId));

    playlistSongs.removeWhere((element) => element.id == songId);
    await playlistBox.put(playlistName, playlistSongs);
    showPlaylistSnackbar(
        context: context,
        songName: song.title,
        message: 'Deleted from playlist');
  }

  static void showPlaylistSnackbar({
    required BuildContext context,
    required String songName,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.blueGrey,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              songName,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
