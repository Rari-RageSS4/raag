import 'dart:math';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raag/audio/songs.dart';
import 'package:raag/components/bottom_sheet.dart';
import 'package:raag/components/neu_box.dart';
import 'package:just_audio/just_audio.dart';
import 'package:raag/functions/favorite_func.dart';
import 'package:raag/functions/recently_func.dart';
import 'package:raag/model/music.dart';

class PlayScreen extends StatefulWidget {
  final Music musicObj;
  final int currentIndex;
  const PlayScreen({
    super.key,
    required this.musicObj,
    required this.currentIndex,
  });

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  Duration? duration;
  late Music musicObjChange;

  @override
  void initState() {
    super.initState();
    musicObjChange = widget.musicObj;
    onPlay(musicObjChange.path);

    if (FavoriteFunctions.isFavor(musicObjChange) == true) {
      isFavorite = true;
    } else {
      isFavorite = false;
    }
    RecentlyFunctions.addToRecentlyPlayed(musicObjChange);
    currentSongIndex = widget.currentIndex;
  }

  late bool isFavorite;
  int currentSongIndex = 0;

  var player = AudioPlayer();

  Future<void> onPlay(String path) async {
    duration = await player.setFilePath(path);
    player.play();

    setState(() {});
  }

  void isFavoriteChanged(bool? value) {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite == false) {
        setState(() {
          FavoriteFunctions.deleteFromFav(musicObjChange.id);
        });
      } else {
        setState(() {
          FavoriteFunctions.addToFavorite(song: musicObjChange);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: gradientBoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                // app bar
                appBar(context),

                const SizedBox(
                  height: 35,
                ),

                // album artist
                imageTitle(),

                const SizedBox(
                  height: 35,
                ),

                // song duration progress
                durationProgress(),

                const SizedBox(
                  height: 30,
                ),

                //playback controls
                playbackControls()
              ],
            ),
          ),
        ),
      ),
    );
  }

  NeuBox imageTitle() {
    return NeuBox(
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: QueryArtworkWidget(
                artworkQuality: FilterQuality.high,
                  artworkHeight: 220,
                  artworkWidth: 250,
                  nullArtworkWidget: Container(
                    height: 220,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                          image: AssetImage('lib/images/purple_music.jpeg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  id: musicObjChange.id,
                  type: ArtworkType.AUDIO,
                ),
          ),
          const SizedBox(
            height: 10,
          ),

          // song and artist name
          titleAndAlbum()
        ],
      ),
    );
  }

  Row appBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // back button
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),

        // title
        title(),

        // menu button
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            )),
      ],
    );
  }

  Column title() {
    return const Column(
      children: [
        Text(
          'Playing from your Library',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Favorite Songs',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }

  Row playbackControls() {
    return Row(
      children: [
        // skip previous
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (currentSongIndex > 0) {
                currentSongIndex = currentSongIndex - 1;
              } else {
                // if its the first song loop back to the last song
                currentSongIndex = songsNotifier.value.length - 1;
              }
              musicObjChange = songsNotifier.value[currentSongIndex];
              onPlay(musicObjChange.path);
            },
            child: const NeuBox(
              child: Icon(Icons.skip_previous),
            ),
          ),
        ),

        const SizedBox(
          width: 20,
        ),

        // play pause
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              if (player.playing) {
                player.pause();
              } else {
                player.play();
              }
              setState(() {});
            },
            child: NeuBox(
              child: Icon(
                player.playing ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ),
        ),

        const SizedBox(
          width: 20,
        ),

        //skip forward
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (currentSongIndex < songsNotifier.value.length - 1) {
                // go to next song if its not last song
                currentSongIndex = currentSongIndex + 1;
              } else {
                currentSongIndex = 0;
              }
              musicObjChange = songsNotifier.value[currentSongIndex];
              onPlay(musicObjChange.path);
            },
            child: const NeuBox(child: Icon(Icons.skip_next)),
          ),
        ),
      ],
    );
  }

  Column durationProgress() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // start time
              StreamBuilder(
                  stream: player.positionStream,
                  builder: (context, duration) {
                    return Text(
                      durationFormat(duration.data ?? Duration.zero),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    );
                  }),

              // shuffle icon
              IconButton(
                icon: const Icon(
                  Icons.shuffle,
                ),
                color: Colors.white,
                onPressed: () {
                  final random = Random();
                    musicObjChange = songsNotifier
                      .value[random.nextInt(songsNotifier.value.length)];
                  onPlay(musicObjChange.path);
                },
              ),

              // end time
              Text(
                durationFormat(duration ?? Duration.zero),
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        StreamBuilder(
            stream: player.positionStream,
            builder: (context, durations) {
              return SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 0),
                ),
                child: Slider(
                    min: 0,
                    max: duration?.inSeconds.toDouble() ?? 1.0,
                    value: player.position.inSeconds.toDouble(),
                    activeColor: const Color.fromARGB(255, 0, 213, 255),
                    onChanged: (value) {
                      player.seek(Duration(seconds: value.round()));
                    }),
              );
            }),
      ],
    );
  }

  Padding titleAndAlbum() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  musicObjChange.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              // heart icon

              IconButton(
                icon: isFavorite
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
                onPressed: () => isFavoriteChanged(isFavorite),
                color: Colors.red,
              ),
              const SizedBox(
                width: 5,
              ),
              IconButton(
                icon: const Icon(Icons.playlist_add),
                onPressed: () {
                  playlistBottomSheet(context, widget.musicObj);
                },
              ),
            ],
          ),
          Text(musicObjChange.album ?? "no album"),
        ],
      ),
    );
  }

  BoxDecoration gradientBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 0, 94, 141),
            Color.fromARGB(255, 12, 121, 176)
          ]),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
  }

  String durationFormat(Duration d) {
    if (d.inHours > 0) {
      return d.toString().split('.').first.padLeft(8, "0");
    }
    return d.toString().substring(2, 7);
  }
}
