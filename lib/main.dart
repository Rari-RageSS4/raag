import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raag/audio/songs.dart';
import 'package:raag/components/bottom_nav_bar.dart';
import 'package:raag/functions/add_song_to_hive.dart';
import 'package:raag/functions/change_song_model.dart';
import 'package:raag/functions/favorite_func.dart';
import 'package:raag/functions/playlist_func.dart';
import 'package:raag/functions/recently_func.dart';
import 'package:raag/model/music.dart';
import 'package:raag/model/playlist.dart';
import 'package:raag/pages/favorite.dart';
import 'package:raag/pages/home.dart';
import 'package:raag/pages/search.dart';
import 'package:raag/pages/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //init hive
  await Hive.initFlutter();

  // register adapter
  Hive.registerAdapter<Music>(MusicAdapter());
  Hive.registerAdapter<Playlist>(PlaylistAdapter());

  // open box
  await Hive.openBox<Music>('musicbox');
  await Hive.openBox<int>('favoriteBox');
  await Hive.openBox<int>('recentlyBox');
  await Hive.openBox<Playlist>('playlistBox');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final OnAudioQuery _audioQuery = OnAudioQuery();
  Music? randomMusic;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    checkAndRequestPermissions();
  }

  Future<void> checkAndRequestPermissions({bool retry = false}) async {
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry
    );
    if(_hasPermission){
      List<SongModel> songModel = await _audioQuery.querySongs();
      await AddSongsToHive.addSongToHive(changeSongModel(songModel));
      await FavoriteFunctions.readFavSongs();
      await PlaylistFunc.getPlaylist();
      await RecentlyFunctions.readRecentSongs();
      final random = Random();
      randomMusic = songsNotifier.value[random.nextInt(songsNotifier.value.length)];
    }    

    _hasPermission ? setState((){}) : null;
  }

  int selectedIndex = 0;

   void onTap(int index){
  setState((){
    selectedIndex = index;
  });
 }
  
  List<Widget> get _pages => [
    Home(randomMusic: randomMusic,),
    const Search(),
    const Favorite(),
    const Settings()
  ]; 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[selectedIndex],
        bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex, onTap: onTap, ),
      )
    );
  }
}