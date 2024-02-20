import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({
    super.key,
    required this.imagePath,
    required this.catName,
    required this.context,
  });

  final String imagePath;
  final String catName;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          CircleAvatar(
            //backgroundColor: Get.theme.cardColor,
            backgroundColor: Theme.of(context).cardColor,
            radius: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                imagePath,
                scale: 1,
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Center(
            child: Text(
              catName,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
