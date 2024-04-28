import 'package:flutter/material.dart';
import 'package:raag/audio/songs.dart';
import 'package:raag/model/music.dart';
import 'package:raag/styles/textstyle.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<Music> searchMusic = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Search',
                    style: TextFontStyle.blueBoldTitle
                  ),
                  searchTextField(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'All Songs',
                    style: TextFontStyle.blueTitle
                  ),
                  SizedBox(
                    height: 550,
                    child: Songs(
                      searchController: searchController, 
                      searchMusic: searchMusic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextField searchTextField() {
    return TextField(
      onSubmitted: (value) => FocusManager.instance.primaryFocus?.unfocus(), // what value
      controller: searchController,
      onChanged: (value){
        searchMusic.clear();
        for(var song in songsNotifier.value){
          if(song.title.toLowerCase().contains(value.toLowerCase())){
            searchMusic.add(song);
          }
        }
        setState(() {});
      },
      decoration: const InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(255, 77, 128, 153),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Icon(Icons.search),
        ),
        border: OutlineInputBorder(),
        hintText: 'What do you want to listen to?',
        labelText: 'Search',
      ),
    );
  }
}
