import 'package:flutter/material.dart';

class PirvacyPolicy extends StatelessWidget {
  const PirvacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy for RAAG'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('''
      At RAAG, accessible from Playstore, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by RAAG and how we use it.
      
      If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.
      
      Log Files
      
      RAAG follows a standard procedure of using log files. These files log visitors when they use the app. All hosting companies do this and a part of hosting services' analytics. The information collected by log files includes internet protocol (IP)
      ''')
          ],
        ),
      ),
    );
  }
}