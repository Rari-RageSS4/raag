import 'package:on_audio_query/on_audio_query.dart';
import 'package:raag/model/music.dart';

List<Music> changeSongModel(List<SongModel> songModel) {
    List<Music> songs = [];
    for (var song in songModel) {
      songs.add(
        Music(
          id: song.id,
          title: song.title,
          album: song.album!,
          path: song.data,
        ),
      );
    }
    return songs;
  }