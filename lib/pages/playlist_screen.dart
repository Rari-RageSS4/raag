import 'package:flutter/material.dart';
import 'package:raag/components/image.dart';
import 'package:raag/components/playlist_popup.dart';
import 'package:raag/model/playlist.dart';
import 'package:raag/pages/play_screen.dart';

class PlaylistEachFolder extends StatefulWidget {
  final Playlist playlistObj;
  final int playlistindex;
  const PlaylistEachFolder({super.key, required this.playlistObj, required this.playlistindex});

  @override
  State<PlaylistEachFolder> createState() => _PlaylistEachFolderState();
}

class _PlaylistEachFolderState extends State<PlaylistEachFolder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 83, 125),
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left),
          onPressed: () => Navigator.pop(context),
          ),
        title: Text(widget.playlistObj.name),
        centerTitle: true
      ),
      body: widget.playlistObj.songs.isEmpty? Center(child: const Text("No songs in this Playlist!")) : ListView.builder(
        itemCount: widget.playlistObj.songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayScreen(musicObj: widget.playlistObj.songs[index], currentIndex: index,),
              ),
            ),
            leading: LeadingImage(id: widget.playlistObj.songs[index].id),
            title: Text(widget.playlistObj.songs[index].title,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(widget.playlistObj.songs[index].album!,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: PlaylistPopUp(musicObj: widget.playlistObj.songs[index], playlistIndex: widget.playlistindex, songIndex: index,),
          );
        },
      ),
    );
  }
}
