import 'package:brew/models/model_user.dart';
import 'package:brew/screens/wrapper.dart';
import 'package:brew/services/auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ModelUser?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (_, __) => null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
