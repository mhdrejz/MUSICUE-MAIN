import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:marquee/marquee.dart';
import 'package:musicue/funtions/alert_function.dart';
import 'package:musicue/funtions/favourites.dart';
import 'package:musicue/funtions/functions.dart';
import 'package:musicue/models/db_functions/db_functions.dart';
import 'package:musicue/models/songs.dart';
import 'package:musicue/screens/favorate_screen.dart';
import 'package:musicue/screens/screen_playlist.dart';
import 'package:musicue/widgets/customIconbutton.dart';
import 'package:musicue/widgets/dbox.dart';
import 'package:musicue/widgets/navBarFunction.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingScreen extends StatefulWidget {
  PlayingScreen({
    super.key,
    required this.index,
    required this.assetsAudioPlayer,
    required this.songList,
  });
  final int index;
  final AssetsAudioPlayer assetsAudioPlayer;
  final List<Audio> songList;

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

Box<Songs> songBox = getSongBox();
List<Songs> songList = songBox.values.toList().cast<Songs>();

class _PlayingScreenState extends State<PlayingScreen> {
  String newLyrics = 'Tap the button to get the Lyrics';

  bool isplaying = true;

  @override
  void initState() {
    // TODO: implement initState
    // convertSongModel();
    super.initState();
    // playSongs();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) {
      return element.path == fromPath;
    });
  }

  bool isLoop = true;
  bool isShuffle = true;

  void shuffleButtonPressed() {
    setState(() {
      widget.assetsAudioPlayer.toggleShuffle();
      isShuffle = !isShuffle;
    });
  }

  void repeatButtonPressed() {
    if (isLoop == true) {
      widget.assetsAudioPlayer.setLoopMode(LoopMode.single);
    } else {
      widget.assetsAudioPlayer.setLoopMode(LoopMode.playlist);
    }
    setState(() {
      isLoop = !isLoop;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return widget.assetsAudioPlayer.builderCurrent(builder: (context, playing) {
      final myAudio = find(widget.songList, playing.audio.assetAudioPath);
      // RecentScreen.addSongsToRecents(songId: myAudio.metas.id!);

      return Scaffold(
        bottomNavigationBar: CustomnavBarFunction(),
        backgroundColor: Colors.grey.shade300,
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                // backbutton and menu button

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
                              icon: Icon(Icons.arrow_back))),
                    ),
                    Text('N O W P L A Y I N G'),
                    Container(
                      height: 60,
                      width: 60,
                      child: dbox(
                          Child: IconButton(
                              onPressed: () {
                                showPlaylistModalSheet(
                                    context: context,
                                    screenHeight: screenHeight,
                                    song: songList[widget.index]);
                              },
                              icon: Icon(Icons.playlist_add))),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: dbox(
                      Child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: QueryArtworkWidget(
                            artworkHeight: screenHeight * 0.4,
                            artworkWidth: double.infinity,
                            id: int.parse(myAudio.metas.id!),
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Image.asset(
                              'assets/images/music gif.gif',
                              fit: BoxFit.cover,
                              height: screenHeight * 0.4,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 280,
                                  height: 30,
                                  child: Marquee(
                                    velocity: 40,
                                    blankSpace: 30,
                                    text: widget
                                        .assetsAudioPlayer.getCurrentAudioTitle,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.grey.shade700),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 6, right: 20),
                                  child: SizedBox(
                                    width: 260,
                                    child: Text(
                                      overflow: TextOverflow.clip,
                                      widget.assetsAudioPlayer
                                          .getCurrentAudioArtist,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            CustomIconButton(
                              icon: Favourites.isThisFavourite(
                                  id: myAudio.metas.id!),
                              onPressed: () {
                                Favourites.addSongToFavourites(
                                  context: context,
                                  id: myAudio.metas.id!,
                                );
                                setState(() {
                                  Favourites.isThisFavourite(
                                    id: myAudio.metas.id!,
                                  );
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
                ),

                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 30, right: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            dbox(
                              Child: CustomIconButton(
                                icon: (isShuffle == true)
                                    ? Icons.shuffle
                                    : Icons.arrow_forward,
                                onPressed: () {
                                  shuffleButtonPressed();
                                },
                              ),
                            ),
                            dbox(
                              Child: CustomIconButton(
                                icon: (isLoop == true)
                                    ? Icons.repeat
                                    : Icons.repeat_one,
                                onPressed: () {
                                  repeatButtonPressed();
                                },
                              ),
                            ),
                          ],
                        ),
                        assetsAudioPlayer.builderRealtimePlayingInfos(
                            builder: (context, Infos) {
                          Duration curentDuration = Infos.currentPosition;
                          Duration totalDuration = Infos.duration;
                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: dbox(
                              Child: ProgressBar(
                                thumbGlowRadius: 3,
                                progressBarColor: Colors.grey,
                                thumbRadius: 6,
                                thumbColor: Colors.grey,
                                progress: curentDuration,
                                total: totalDuration,
                                onSeek: (to) {
                                  assetsAudioPlayer.seek(to);
                                },
                              ),
                            ),
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: SizedBox(
                            height: 60,
                            child: Row(
                              children: [
                                Expanded(
                                    child: dbox(
                                        Child: InkWell(
                                  onDoubleTap: () {},
                                  child: IconButton(
                                      onPressed: () {
                                        widget.assetsAudioPlayer.previous();
                                      },
                                      icon: Icon(Icons.skip_previous)),
                                ))),
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: dbox(
                                        Child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (isplaying == true) {
                                                  widget.assetsAudioPlayer
                                                      .pause();
                                                  isplaying == false;
                                                } else {
                                                  widget.assetsAudioPlayer
                                                      .play();
                                                  isplaying == true;
                                                }
                                                isplaying = !isplaying;
                                              });
                                            },
                                            icon: isplaying == true
                                                ? Icon(Icons.pause)
                                                : Icon(Icons.play_arrow)),
                                      ),
                                    )),
                                Expanded(
                                    child: dbox(
                                        Child: InkWell(
                                  onDoubleTap: () {},
                                  child: IconButton(
                                      onPressed: () {
                                        widget.assetsAudioPlayer.next();
                                      },
                                      icon: Icon(Icons.skip_next)),
                                )))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
        ),
      );
    });
  }
//   showMusicLyricBottomSheet({
//     required BuildContext context,
//     required double screenHeight,
//     required Audio myAudio,
//   })
//  {
//     showModalBottomSheet(
//         context: context,
//         backgroundColor: Colors.transparent,
//         builder: (context) {
//           return StatefulBuilder(
//               builder: (BuildContext ctx, StateSetter setState) {
//             return Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30),
//                 color: Color(0xFF201C1B),
//               ),
//               height: screenHeight * 0.55,
//               child: Column(
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: StadiumBorder(), backgroundColor: kBlue),
//                     onPressed: () async {
//                       if (myAudio.metas.artist != '<unknown>') {
//                         final lyricsData = await getSongLyrics(
//                             title: myAudio.metas.title!,
//                             artist: myAudio.metas.artist!);

//                         setState(() {
//                           newLyrics = lyricsData.lyrics;
//                         });
//                       } else {
//                         setState(() {
//                           newLyrics =
//                               'Unable to find the lyrics due to Unknown artist';
//                         });
//                       }
//                     },
//                     child: const Text(
//                       'Get lyrics',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Text(
//                         newLyrics,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           });
//         });
//   }
}
