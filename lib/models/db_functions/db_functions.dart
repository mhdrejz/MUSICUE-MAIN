import 'package:hive_flutter/adapters.dart';
import 'package:musicue/models/songs.dart';

Box<Songs> getSongBox() {
  return Hive.box<Songs>('Songs');
}

Box<List> getPlaylistBox() {
  return Hive.box<List>('Playlist');
}
