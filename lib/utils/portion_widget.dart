import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holmon/utils/dimensions.dart';

class PortionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool hideDivider;
  final String route;
  final String? suffix;
  const PortionWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.route,
      this.hideDivider = false,
      this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => Get.offNamed(route),
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
        child: Column(children: [
          Row(children: [
            Container(child: Icon(icon), height: 16, width: 16),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Expanded(child: Text(title)),
            suffix != null
                ? Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.error,
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusDefault),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeExtraSmall,
                        horizontal: Dimensions.paddingSizeSmall),
                    child: Text(suffix!, textDirection: TextDirection.ltr),
                  )
                : const SizedBox(),
          ]),
          //hideDivider ? const SizedBox() : const Divider()
        ]),
      ),
    );
  }
}
