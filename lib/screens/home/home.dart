import 'package:brew/models/brew.dart';
import 'package:brew/services/database.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth.dart';
import 'brew_list.dart';



class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService().brews,
      initialData:null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
               await _auth.signOut();
              },
              icon: const Icon(Icons.person),
              label: const Text('logout'),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
