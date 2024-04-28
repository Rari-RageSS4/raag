import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raag/components/image.dart';
import 'package:raag/components/pop_up.dart';
import 'package:raag/model/music.dart';
import 'package:raag/pages/play_screen.dart';

ValueNotifier<List<Music>> songsNotifier = ValueNotifier([]);

class Songs extends StatefulWidget {
  final TextEditingController searchController;
  final List<Music> searchMusic;
  const Songs({
    super.key,
    required this.searchController,
    required this.searchMusic,
  });

  @override
  State<Songs> createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  bool _hasPermission = false;
  final OnAudioQuery _audioQuery = OnAudioQuery();
  late Box box;

  @override
  void initState() {
    super.initState();
    //  checkAndRequestPermissions();
    box = Hive.box<Music>('musicbox');
  }

  checkAndRequestPermissions({bool retry = false}) async {
    _hasPermission = await _audioQuery.checkAndRequest(retryRequest: retry);
    _hasPermission ? setState(() {}) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music'),
        elevation: 2,
      ),
      body: Center(
        child: !_hasPermission ? noAccessToLibraryWidget() : _buildSongList(),
      ),
    );
  }

  Widget _buildSongList() {
    return ValueListenableBuilder(
        valueListenable: songsNotifier,
        builder: (context, List<Music> songs, child) {
          // if no music
          if (songs.isEmpty) {
            return const Center(
              child: Text(
                "Music list is empty",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }
          // if searched song not found
          if (widget.searchController.text.isNotEmpty &&
              widget.searchMusic.isEmpty) {
            return const Center(
              child: Text(
                "No Music found",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            itemCount: widget.searchController.text.isNotEmpty
                ? widget.searchMusic.length ///////
                : songs.length, /////////
            itemBuilder: (context, index) {
              final Music song;
              if (widget.searchMusic.isNotEmpty &&
                  widget.searchController.text.isNotEmpty) {
                song = widget.searchMusic[index];
              } else {
                song = songs[index];
              }
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayScreen(
                        musicObj: song,
                        currentIndex: index,
                      ),
                    ),
                  );
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                title: Text(
                  song.title,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(song.album ?? 'Empty',
                    overflow: TextOverflow.ellipsis),
                leading: LeadingImage(id: song.id),
                trailing: PopUp(
                  musicObj: song,
                ),
              );
            },
          );
        });
  }

  Widget noAccessToLibraryWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Application doesn't have access to the library"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => checkAndRequestPermissions(retry: true),
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }
}
