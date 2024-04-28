import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:raag/components/sub_components/playlist_menu_items.dart';
import 'package:raag/model/music.dart';

class PlaylistPopUp extends StatefulWidget {
  final int playlistIndex;
  final int songIndex;
  final Music musicObj;
  const PlaylistPopUp({
    super.key,
    required this.musicObj,
    required this.playlistIndex,
    required this.songIndex,
  });

  @override
  State<PlaylistPopUp> createState() => _PlaylistPopUpState();
}

class _PlaylistPopUpState extends State<PlaylistPopUp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPopover(
          direction: PopoverDirection.left,
          context: context,
          bodyBuilder: (context) => PlaylistMenuItems(
            musicObj: widget.musicObj,
            index: widget.playlistIndex,
            songIndex: widget.songIndex,
          ),
          width: 250,
          height: 88,
        );
        setState(() {
          
        });
      },
      child: const Icon(Icons.more_vert),
    );
  }
}
