import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:raag/components/empty_dialog.dart';
import 'package:raag/components/playlist_folder_popup.dart';
import 'package:raag/components/playlist_name.dart';
import 'package:raag/functions/playlist_func.dart';
import 'package:raag/model/playlist.dart';
import 'package:raag/pages/playlist_screen.dart';
import 'package:raag/styles/textstyle.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({
    super.key,
  });

  @override
  State<PlaylistScreen> createState() => _PlaylistState();
}

class _PlaylistState extends State<PlaylistScreen> {
  late Box playlistBox;

  @override
  void initState() {
    super.initState();
    playlistBox = Hive.box<Playlist>('playlistBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text('My Playlist', style: TextFontStyle.boldWhiteTitle),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 53, 120, 153),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 128, 192, 223),
                Color.fromARGB(255, 53, 120, 153)
              ])),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // folders
                ValueListenableBuilder(
                    valueListenable: playlistNotifier,
                    builder: (context, playlist, child) {
                      if(playlist.isEmpty){
                        return Padding(
                    padding: const EdgeInsets.only(top: 130),
                    child: const EmptyDialog(name: 'Playlist'),
                  );
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: playlist.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlaylistEachFolder(
                                    playlistObj: playlist[index],
                                    playlistindex: index,
                                  ),
                                ),
                              ),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.blueGrey,
                                        Color.fromARGB(255, 30, 94, 126)
                                      ]),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(playlist[index].name,
                                            style: TextFontStyle.whiteSubTitle,
                                            overflow: TextOverflow.ellipsis,
                                            ),
                                      ),
                                      PlaylistFolderPopUp(
                                        index: index, folderName: playlist[index].name,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
      // floating button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 112, 172, 202),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: () {
          PlaylistName createFolderName = PlaylistName();
          createFolderName.playlistName(context);
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 0, 88, 133),
        ),
      ),
    );
  }
}
