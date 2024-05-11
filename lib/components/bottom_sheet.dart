import 'package:flutter/material.dart';
import 'package:raag/components/empty_dialog.dart';
import 'package:raag/functions/playlist_func.dart';
import 'package:raag/model/music.dart';

Future playlistBottomSheet(BuildContext context, Music song){
    return showModalBottomSheet(
      context: context, 
      backgroundColor: const Color.fromARGB(255, 65, 147, 188),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30)
        )
      ),
      builder: (context) => SizedBox(
        height: 500,
        child: ValueListenableBuilder(
          valueListenable: playlistNotifier,
          builder: (context, playlist, child) {
            if(playlist.isEmpty){
              return Padding(
                padding: const EdgeInsets.only(top: 130),
                child: const EmptyDialog(name: 'Favourite'),
              );
            }
            return ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index){
                return ListTile(
                  onTap: (){
                    PlaylistFunc.addSongToPlaylist(index, song, context);
                    Navigator.pop(context);
                  },
                  title: Text(playlist[index].name),
                );
              }
            );
          }
        ),
      ),
    );
  }