import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double width;
  final double height;
  LoadingIndicator({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: width, height: height, child: CircularProgressIndicator()));
  }
}
