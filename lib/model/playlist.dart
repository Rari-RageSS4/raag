import 'package:hive/hive.dart';
import 'package:raag/model/music.dart';

part 'playlist.g.dart';

@HiveType(typeId: 1)
class Playlist extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<Music> songs;

  Playlist({required this.name,required this.songs});
}
