import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holmon/constants/assets.dart';
import 'package:holmon/domain/cartViewModel.dart';
import '../../models/dto/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  CartItemWidget({Key? key, required this.item}) : super(key: key);

  final ShoppingCartViewModel cartViewModel = Get.find<ShoppingCartViewModel>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => {Get.toNamed('/details', arguments: item)},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xffE9F5FA)),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: CachedNetworkImage(
                  imageUrl: item.imagefrontsmallurl!,
                  width: 40,
                  height: 40,
                  filterQuality: FilterQuality.none,
                  //fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            )),
            SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productname ?? "????",
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("${item.price ?? "10da"} / ${item.quantity}",
                      style: TextStyle(
                          color: Color(0xffFF324B),
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffE9F5FA),
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (() {
                        cartViewModel.addToCart(item);
                      }),
                      child: Image.asset(
                        Assets.imagesAddIcon,
                        width: 28,
                        height: 28,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      item.itemQuantity.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        //color: Colors.black
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        cartViewModel.removeFromCart(item);
                      },
                      child: Image.asset(
                        Assets.imagesRemoveIcon,
                        width: 28,
                        height: 28,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
