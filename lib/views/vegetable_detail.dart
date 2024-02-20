import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holmon/constants/assets.dart';
import 'package:holmon/domain/cartViewModel.dart';
import 'package:holmon/models/dto/cart.dart';
import 'package:holmon/models/dto/product.dart';
import 'package:holmon/views/common_widgets/appBar.dart';
import 'package:holmon/views/common_widgets/search_text_field.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'common_widgets/item_key_points_view.dart';

class VegetableDetailScreen extends StatefulWidget {
  const VegetableDetailScreen({Key? key}) : super(key: key);

  @override
  State<VegetableDetailScreen> createState() => _VegetableDetailScreenState();
}

class _VegetableDetailScreenState extends State<VegetableDetailScreen> {
  int itemCount = 0;
  final ShoppingCartViewModel cartViewModel = Get.find<ShoppingCartViewModel>();

  final Product product = Get.arguments;
  late final List<CachedNetworkImageProvider> multiImageProvider;

  @override
  void initState() {
    super.initState();

    multiImageProvider = [
      CachedNetworkImageProvider(product.imagefronturl ?? ''),
      CachedNetworkImageProvider(product.imagenutritionurl ?? ''),
    ];
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: const SearchTextField(
            hint: "What are u looking for ?",
            readOnly: true,
          ),
          leading:
              InkResponse(onTap: () => Get.back(), child: BackButtonIcon()),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.favorite_border_rounded),
            )
          ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkResponse(
                    onTap: () => {
                      Get.to(() => PhotoViewGallery.builder(
                            scrollPhysics: const BouncingScrollPhysics(),
                            builder: (BuildContext context, int index) {
                              return PhotoViewGalleryPageOptions(
                                maxScale: PhotoViewComputedScale.covered * 1.1,
                                minScale:
                                    PhotoViewComputedScale.contained * 0.8,
                                imageProvider: multiImageProvider[index],
                                initialScale:
                                    PhotoViewComputedScale.contained * 0.8,
                                heroAttributes: PhotoViewHeroAttributes(
                                    tag: product.id ?? ""),
                              );
                            },
                            itemCount: multiImageProvider.length,
                            pageController: PageController(initialPage: 0),
                          ))
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                  width: 4, color: Get.theme.primaryColor),
                              left: BorderSide(
                                  width: 4, color: Get.theme.primaryColor),
                              right: BorderSide(
                                  width: 4, color: Get.theme.primaryColor)),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.elliptical(
                                  MediaQuery.of(context).size.width, 140.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Hero(
                          tag: product.id!,
                          child: CachedNetworkImage(
                            imageUrl: product.imagefronturl ?? "",
                            width: 140,
                            height: 180,
                            filterQuality: FilterQuality.low,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${product.price ?? 10.00} / ${product.quantity}",
                          style: TextStyle(
                            color: Color(0xffFF324B),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          product.productname ?? "????",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          "Quantity : ${product.quantity}",
                          style: TextStyle(
                            color: Get.theme.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          "tags: ${product.categories}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Row(
                          children: [
                            ItemKeyPointsView(
                                imagePath: Assets.imagesOrganic,
                                title: "100%",
                                desc: "Organic"),
                            SizedBox(
                              width: 8,
                            ),
                            ItemKeyPointsView(
                                imagePath: Assets.imagesHouse,
                                title: "1 Year",
                                desc: "Expiration")
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            ItemKeyPointsView(
                                imagePath: Assets.imagesReviews,
                                title: "4.8",
                                desc: "Reviews"),
                            SizedBox(
                              width: 8,
                            ),
                            ItemKeyPointsView(
                                imagePath: Assets.imagesCalories,
                                title: "80 kcal",
                                desc: product.quantity ?? "200 Gram")
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Get.theme.cardColor.withOpacity(0.6),
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text("Total price (with tax)",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: 4,
                          ),
                          Text("${product.price ?? 10.00}",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: Obx(
                          () {
                            final cartItem = cartViewModel
                                    .productCartMap[product.id.toString()] ??
                                null;
                            return cartItem != null && cartItem.id == product.id
                                ? _buildCartActions(cartItem)
                                : _buildCartNoActions();
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCartNoActions() {
    return ElevatedButton(
      onPressed: () => {
        cartViewModel.addToCart(CartItem(
          id: product.id,
          productname: product.productname,
          price: product.price,
          quantity: product.quantity,
          itemQuantity: 1,
          imagefrontsmallurl: product.imagefrontsmallurl,
          imagefronturl: product.imagefronturl,
          categories: product.categories,
        ))
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        shape: StadiumBorder(),
        backgroundColor: Get.theme.primaryColor,
      ),
      child: Text(
        "Add to cart",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildCartActions(CartItem cartItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkResponse(
          onTap: () {
            cartViewModel.addToCart(cartItem);
          },
          child: Image.asset(
            Assets.imagesAddIcon,
            width: 40,
            height: 40,
          ),
        ),
        SizedBox(width: 20),
        Text(
          (cartItem.itemQuantity).toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 20),
        InkResponse(
          onTap: () {
            cartViewModel.removeFromCart(cartItem);
          },
          child: Image.asset(
            Assets.imagesRemoveIcon,
            width: 40,
            height: 40,
          ),
        ),
      ],
    );
  }
}
