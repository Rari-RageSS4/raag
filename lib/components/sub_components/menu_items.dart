import 'package:flutter/material.dart';
import 'package:raag/components/added_success_snackbar.dart';
import 'package:raag/components/bottom_sheet.dart';
import 'package:raag/functions/favorite_func.dart';
// import 'package:raag/functions/playlist_func.dart';
import 'package:raag/model/music.dart';
//import 'package:raag/model/playlist.dart';

class MenuItems extends StatelessWidget {
  final Music musicObj;
  
  const MenuItems({
    super.key,
    required this.musicObj,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1st menu option
        if(FavoriteFunctions.isFavor(musicObj) == false)
        GestureDetector(
          onTap: () {
            FavoriteFunctions.addToFavorite(song: musicObj);
            showSnackbar(context);
            Navigator.pop(context);
          },
          child: Container(
            height: 50,
            color: Colors.blueGrey[300],
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Add to favorite'),
              ],
            ),
          ),
        ),
        // 2nd menu
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            playlistBottomSheet(context, musicObj);
          },
          child: Container(
            height: 50,
            color: Colors.blueGrey[200],
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Add to playlist'),
              ],
            ),
          ),
        ),
        // 3rd menu
        if(FavoriteFunctions.isFavor(musicObj) == true)
        GestureDetector(
          onTap: () {
            FavoriteFunctions.deleteFromFav(musicObj.id);
            showRemoveSnackbar(context);
            Navigator.pop(context);
          },
          child: Container(
            height: 50,
            color: Colors.blueGrey[300],
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Remove from Favourite'),
              ],
            ),
          ),
        ),
      ],
    );
  }

   void showRemoveSnackbar(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Removed Successfully'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.green,
      ),
    );
  }
}