import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  static const title = 'Profile';
  static const androidIcon = Icon(Icons.person);
  static const iosIcon = Icon(CupertinoIcons.person);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Profile'),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/ryan.jpeg'), // Replace with your image
                  ),
                  SizedBox(height: 20),
                  Text(
                    'John Doe', // Replace with the user's name
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'john.doe@example.com', // Replace with user's email or additional info
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Action when the button is pressed
                    },
                    child: Text('Edit Profile'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
