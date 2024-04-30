import 'package:flutter/material.dart';
import 'package:raag/pages/privacy_policy.dart';
import 'package:raag/pages/terms_and_condtions.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  void _showDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.blueGrey,
            title: Text('About R A A G'),
            content: Text(
                'Raag is a Muslic platform where you can listen to your favorite music from your phone with ease access and segregating them by categories and more features on the way!'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 94, 141),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              ListTile(
                onTap: () => _showDialog(context),
                leading: const Icon(Icons.info),
                title: const Text('About Us'),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TermsAndConditions(),
                    )),
                leading: const Icon(Icons.assignment),
                title: const Text('Terms and conditions'),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PirvacyPolicy(),
                    )),
                leading: const Icon(Icons.library_books),
                title: const Text('Privacy Policy'),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
          Positioned(
            bottom: 5,
            left: 130,
            child: Text("Version: 1.0.0",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }
}
