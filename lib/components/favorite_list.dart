import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raag/components/pop_up.dart';
import 'package:raag/model/music.dart';
import 'package:raag/pages/play_screen.dart';

class FavoriteList extends StatelessWidget {
  final Music musicObj;
  final int index;
  const FavoriteList({
    super.key,
    required this.musicObj, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayScreen(musicObj: musicObj, currentIndex: index,),
              ),
            ),
        leading: QueryArtworkWidget(
          nullArtworkWidget: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('lib/images/purple_music.jpeg'),
                  fit: BoxFit.cover),
            ),
          ),
          id: musicObj.id,
          type: ArtworkType.AUDIO,
        ),
        title: Text(
          musicObj.title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 88, 133),
          ),
        ),
        subtitle: Text(
          musicObj.album ?? "No Album",
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 88, 133),
          ),
        ),
        trailing: PopUp(
          musicObj: musicObj,
        ));
  }
}
