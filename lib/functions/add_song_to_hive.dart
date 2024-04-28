import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:raag/audio/songs.dart';
import 'package:raag/model/music.dart';

class AddSongsToHive extends ChangeNotifier{
  static Future<void> addSongToHive(List<Music> songs) async{
    songsNotifier.value.clear();
    final box = Hive.box<Music>('musicbox');
    await box.addAll(songs); // first time only?
    songsNotifier.value.addAll(songs);
    songsNotifier.notifyListeners();
  }
}

