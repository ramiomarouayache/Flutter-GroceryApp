import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ItemKeyPointsView extends StatelessWidget {
  const ItemKeyPointsView({
    super.key,
    required this.imagePath,
    required this.title,
    required this.desc,
  });

  final String imagePath;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Get.theme.cardColor)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff23AA49)),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(desc,
                    style: TextStyle(
                        fontSize: 14, overflow: TextOverflow.ellipsis)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
