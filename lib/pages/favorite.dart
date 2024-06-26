import 'package:flutter/material.dart';
import 'package:raag/components/empty_dialog.dart';
import 'package:raag/components/favorite_list.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:raag/functions/favorite_func.dart';
import 'package:raag/model/music.dart';
import 'package:raag/styles/textstyle.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color.fromARGB(255, 0, 125, 188), Color.fromARGB(255, 0, 67, 100)]
                    ),
                  ),
                  height: 300,
                  child: Center(
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color.fromARGB(255, 0, 67, 100), Color.fromARGB(255, 0, 125, 188)]
                      ),
                    ),
                    child: const Center(
                      child: GradientIcon(
                        icon: Icons.favorite,
                        gradient: LinearGradient(
                          colors: [Color.fromARGB(255, 157, 224, 255), Colors.blueGrey],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        size: 70,
                      ),
                    ),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                const Positioned(
                  top: 35,
                  left: 125,
                  child: Text('Favourite Songs',
                    style: TextFontStyle.boldWhiteTitle
                  ),
                ),
              ],
            ),
            
            
            const SizedBox(height: 10),
            
            // list 
            
            ValueListenableBuilder(
              valueListenable: favoriteNotifier,
              builder: (context, List<Music> favSongs, child){ 
                if(favSongs.isEmpty){
                  return Padding(
                    padding: const EdgeInsets.only(top: 130),
                    child: const EmptyDialog(name: 'Favourite'),
                  );
                }
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: favSongs.length,
                  itemBuilder: (context, index){
                  return FavoriteList(musicObj: favSongs[index], index: index,);
                },
                );
              }
            ),
          ],
        ),
      )
    );
  }
}