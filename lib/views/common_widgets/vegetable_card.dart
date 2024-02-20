import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holmon/constants/assets.dart';
import 'package:holmon/domain/cartViewModel.dart';
import 'package:holmon/models/dto/cart.dart';
import 'package:holmon/models/dto/product.dart';

class VegetableCardWidget extends StatelessWidget {
  final Product product;
  VegetableCardWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ShoppingCartViewModel cartViewModel = Get.find<ShoppingCartViewModel>();

  @override
  Widget build(BuildContext context) {
    return Material(
      //color: Get.theme.cardColor,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xffF1F1F5)),
            borderRadius: BorderRadius.circular(8)),
        width: (MediaQuery.of(context).size.width / 2) - 34,
        //height: 600,
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InkResponse(
                  onTap: () => Get.toNamed('/details', arguments: product),
                  child: Hero(
                    tag: product.id!,
                    child: CachedNetworkImage(
                      imageUrl: product.imagefrontsmallurl ?? "",
                      width: 120,
                      height: 120,
                      filterQuality: FilterQuality.none,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product.price ?? "10da",
                    style: TextStyle(
                      color: Color(0xffFF324B),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      product.regularPrice ?? "20da",
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Get.theme.colorScheme.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      product.discount ?? "20%",
                      style: TextStyle(
                          color: Color.fromARGB(255, 27, 133, 185),
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product.productname ?? "????",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 48,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () {
                  final cartItem =
                      cartViewModel.productCartMap[product.id.toString()] ??
                          null;
                  return cartItem != null && cartItem.id == product.id
                      ? _buildCartActions(cartItem)
                      : _buildCartNoActions();
                },
              ),
            ),
          ),
          Positioned(
            top: 0, // to shift little up
            left: 0,
            child: Container(
                width: 40,
                height: 40,
                //color: Colors.amber.shade100,
                decoration: BoxDecoration(
                    color: Color(0xffE9F5FA),
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(8))),
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(product.discount ?? "20%",
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Get.theme.primaryColor)),
                    Text("OFF",
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Get.theme.primaryColor))
                  ],
                )),
          )
        ]),
      ),
    );
  }

  Widget _buildCartActions(CartItem cartItem) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
          color: Color(0xffE9F5FA), borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: [
          InkResponse(
            onTap: () {
              cartViewModel.addToCart(cartItem);
            },
            child: Image.asset(
              Assets.imagesAddIcon,
              width: 28,
              height: 28,
            ),
          ),
          SizedBox(width: 4),
          Text(
            (cartItem.itemQuantity).toString(),
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(width: 8),
          InkResponse(
            onTap: () {
              cartViewModel.removeFromCart(cartItem);
            },
            child: Image.asset(
              Assets.imagesRemoveIcon,
              width: 28,
              height: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartNoActions() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      child: InkResponse(
        onTap: () {
          cartViewModel.addToCart(CartItem(
            id: product.id,
            productname: product.productname,
            quantity: product.quantity,
            price: product.price,
            itemQuantity: 1,
            imagefrontsmallurl: product.imagefrontsmallurl,
            imagefronturl: product.imagefronturl,
            categories: product.categories,
          ));
        },
        child: Image.asset(
          Assets.imagesAddIcon,
          width: 28,
          height: 28,
        ),
      ),
    );
  }
}
