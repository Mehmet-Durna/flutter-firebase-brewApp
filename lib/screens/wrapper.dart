import 'package:brew/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/model_user.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<ModelUser?>(context);
    print('$user from wrapper');

    //return either Home or Authenticate Widget
  if (user == null){
    return Authenticate();
  }else{
    return Home();
  }
}
}
