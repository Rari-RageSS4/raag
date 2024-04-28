import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:raag/components/sub_components/menu_items.dart';
import 'package:raag/model/music.dart';

class PopUp extends StatelessWidget {
  final Music musicObj;
  const PopUp({
    super.key,
    required this.musicObj, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPopover(
        direction: PopoverDirection.left,
        context: context, 
        bodyBuilder: (context) => MenuItems(musicObj: musicObj,),
        width: 250,  
        height: 88,  
      ),
      child: const Icon(Icons.more_vert),
    );
  }
}