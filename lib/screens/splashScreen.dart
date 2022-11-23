import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicue/models/db_functions/db_functions.dart';
import 'package:musicue/models/songs.dart';
import 'package:musicue/screens/homeScreen.dart';
import 'package:musicue/widgets/dbox.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  OnAudioQuery audioQuery = OnAudioQuery();

  Box<Songs> songBox = getSongBox();
  Box<List> playlistBox = getPlaylistBox();

  List<SongModel> deviceSongs = [];
  List<SongModel> fetchedSongs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
    fetchSongs();
    gotoHome(context);
  }

  Future fetchSongs() async {
    await Permission.storage.request();
    deviceSongs = await audioQuery.querySongs(
      sortType: SongSortType.TITLE,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    for (var song in deviceSongs) {
      if (song.fileExtension == 'mp3' || song.fileExtension == 'm4a') {
        fetchedSongs.add(song);
      }
    }

    for (var audio in fetchedSongs) {
      final song = Songs(
        id: audio.id.toString(),
        title: audio.displayNameWOExt,
        artist: audio.artist!,
        uri: audio.uri!,
      );
      await songBox.put(song.id, song);
    }
    getFavSongs();
    getMostPlayedSongs();
    getRecentSongs();
    gotoHome(context);
  }

  Future getFavSongs() async {
    if (!playlistBox.keys.contains('Favourites')) {
      await playlistBox.put('Favourites', []);
    }
  }

  Future getRecentSongs() async {
    if (!playlistBox.keys.contains('Recent')) {
      await playlistBox.put('Recent', []);
    }
  }

  Future getMostPlayedSongs() async {
    if (!playlistBox.keys.contains('Most Played')) {
      await playlistBox.put('Most Played', []);
    }
  }

  void requestPermission() {
    Permission.storage.request();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Image.asset(
          'assets/images/MUSICUE splash screen.jpg',
          fit: BoxFit.cover,
        )),
      ),
    );
  }

  // ignore: dead_code
  Future<void> gotoHome(context) async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => const HomeScreen(),
      ),
    );
  }
}
