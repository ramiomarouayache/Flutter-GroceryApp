import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holmon/constants/assets.dart';
import 'package:holmon/domain/cartViewModel.dart';
import 'package:holmon/utils/helper.dart';
import 'package:holmon/views/common_widgets/appBar.dart';
import 'package:lottie/lottie.dart';
import 'common_widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final ShoppingCartViewModel cartViewModel = Get.find<ShoppingCartViewModel>();

  final RxBool isCartEmpty = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: const MyAppBar(
        title: Text(
          "Cart 🛒",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Obx(() {
                final cartItemList =
                    cartViewModel.productCartMap.values.toList();
                if (cartItemList.isEmpty) {
                  isCartEmpty.value = true;
                  return Center(
                    child: Image.asset(
                      Assets.imagesEmptyCart,
                      width: 300,
                      height: 300,
                      filterQuality: FilterQuality.none,
                    ),
                  );
                }
                return Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Color(0xffF1F1F5),
                          );
                        },
                        itemCount: cartViewModel.productCartMap.length,
                        itemBuilder: (context, index) {
                          return CartItemWidget(
                            item: cartItemList[index],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Text(
                          "Your shopping cart will remain saved for the next 72 hours and we will send you a notification to complete your purchase.",
                          style: TextStyle(
                              fontSize: 12,
                              color: Get.theme.colorScheme.primary),
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Get.theme.cardColor.withOpacity(0.6),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                        "Add more items to meet the 1200da min order value",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Get.theme.bottomNavigationBarTheme
                                .backgroundColor)),
                  ),
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
                          Obx(() {
                            final cartItemList =
                                cartViewModel.productCartMap.values.toList();
                            return Text(
                                cartItemList.isEmpty
                                    ? "0.00da"
                                    : cartItemList
                                            .map((e) =>
                                                double.parse((e.price ?? "10da")
                                                    .replaceAll("da", "")) *
                                                e.itemQuantity)
                                            .reduce((value, element) =>
                                                value + element)
                                            .toStringAsFixed(2) +
                                        "da",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold));
                          })
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Obx(() {
                          final cartItemList =
                              cartViewModel.productCartMap.values.toList();
                          return ElevatedButton(
                            onPressed: () => {
                              cartItemList.isEmpty
                                  ? null
                                  : Get.dialog(
                                      Dialog(
                                        child: Container(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Thanks for checking out!",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Lottie.asset(
                                                Assets.imagesDeveloperCoffe,
                                                width: 300,
                                                addRepaintBoundary: true,
                                                //height: 300,
                                                repeat: false,
                                                decoder: customDecoder,
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "This free starter version is designed for friends and developers, so not all features are available. if u have any questions feel free to contact us at",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text("Settings > About us.",
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                  )),
                                              SizedBox(height: 14),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: ElevatedButton(
                                                      onPressed: () => {
                                                        Get.back()
                                                      }, // Close the dialog
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor: Get
                                                            .theme.primaryColor,
                                                        //side: BorderSide.none,
                                                      ),
                                                      child: const Text(
                                                        "Close",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              textStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                              shape: StadiumBorder(),
                              backgroundColor: cartItemList.isNotEmpty
                                  ? Get.theme.primaryColor
                                  : Get.theme.disabledColor,
                            ),
                            child: Text(
                              "Checkout",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }),
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
}
