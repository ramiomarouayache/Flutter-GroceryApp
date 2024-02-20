import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeeAllView extends StatelessWidget {
  const SeeAllView({
    super.key,
    required this.context,
    required this.name,
    required this.onTapAction,
  });

  final BuildContext context;
  final String name;
  final Function onTapAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        InkResponse(
          onTap: () {
            onTapAction();
          },
          child: Text(
            "See All",
            style: TextStyle(
                fontSize: 14,
                color: Get.theme.primaryColor,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
