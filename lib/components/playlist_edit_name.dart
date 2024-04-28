import 'package:flutter/material.dart';
import 'package:raag/functions/playlist_func.dart';
import 'package:raag/styles/textstyle.dart';

class PlaylistEditName {
  final _key = GlobalKey<FormState>();
  String folderName = "";
  TextEditingController folderNameController = TextEditingController();

  void saveEditFolder(int index) {
    final isValid = _key.currentState?.validate();

    if (isValid != null && isValid) {
      _key.currentState?.save();
      PlaylistFunc.updateFolderName(index, folderName);
    }
  }

  Future<dynamic> folderNameAlertDialog(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 78, 138, 168),
          title: const Text(
            'Give your playlist a name',
            style: TextFontStyle.italicWhiteSubTitle,
          ),
          content: Form(
            key: _key,
            child: TextFormField(
              controller: folderNameController,
              decoration: const InputDecoration(labelText: 'Folder Name'),
              onSaved: (value) {
                folderName = value.toString();
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                // save folder
                saveEditFolder(index);
                Navigator.pop(context);
                folderNameController.clear();
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Color.fromARGB(255, 0, 89, 133)),
              ),
            ),
          ],
        );
      },
    );
  }
}
