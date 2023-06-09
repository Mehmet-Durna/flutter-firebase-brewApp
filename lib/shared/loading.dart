import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



// loading class
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: const Center(
        child: SpinKitCubeGrid(
          color: Colors.brown,
          size: 50.0,
        ),
      ),
    );
  }
}