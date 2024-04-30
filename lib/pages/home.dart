import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:raag/components/recently_played_listview.dart';
import 'package:raag/functions/recently_func.dart';
import 'package:raag/model/music.dart';
import 'package:raag/pages/play_screen.dart';
import 'package:raag/pages/playlist_folders.dart';
import 'package:raag/styles/textstyle.dart';

class Home extends StatefulWidget {
  final Music? randomMusic;
  const Home({super.key, required this.randomMusic, });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 83, 125),
              Color.fromARGB(255, 1, 130, 195),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Happy Music', style: TextFontStyle.boldWhiteTitle),
              const Text('Today\'s Shuffled song for you',
                  style: TextFontStyle.whiteSubTitle),
              const SizedBox(
                height: 30,
              ),
              if(widget.randomMusic != null)
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PlayScreen(musicObj: widget.randomMusic!, currentIndex: 0),
                  ),
                ),
                child: QueryArtworkWidget(
                  artworkHeight: 250,
                  artworkWidth: 300,
                  nullArtworkWidget: Container(
                    height: 250,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                          image: AssetImage('lib/images/purple_music.jpeg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  id: widget.randomMusic!.id,
                  type: ArtworkType.AUDIO,
                ),
              ),
          
              const SizedBox(
                height: 30,
              ),
              const Text('Your Playlist',
                  style: TextFontStyle.italicWhiteSubTitle),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage('lib/images/purple_music.jpeg'),
                            fit: BoxFit.cover)),
                  ),
                  IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 100,
                        color: Color.fromARGB(255, 0, 149, 224),
                      ),
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PlaylistScreen(),
                            ),
                          )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
          
              const Divider(),
              const SizedBox(
                height: 20,
              ),
          
              // recently played
          
              const Text('Recently Played',
                  style: TextFontStyle.italicWhiteSubTitle),
              const SizedBox(
                height: 30,
              ),
          
              ValueListenableBuilder(
                valueListenable: recentlyNotifier,
                builder: (BuildContext context, List<Music> recentlySongs,
                    Widget? child) {
                      if(recentlySongs.isEmpty){
                        return Padding(
                    padding: const EdgeInsets.only(top: 80, bottom: 150),
                    child: Center(child: const Text("No Recently played songs!",
                      style: TextFontStyle.whiteSubTitle,
                    ),
                    ),
                  );
                      }
                  return ListView.builder(
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recentlySongs.length,
                    itemBuilder: (context, index) {
                      return RecentlyPlayedListview(
                        musicObj: recentlySongs[index],
                        index: index,
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
