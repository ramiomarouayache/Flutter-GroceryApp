import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holmon/domain/categorieViewModel.dart';
import 'package:holmon/domain/productViewModel.dart';
import 'package:holmon/models/dto/categorie.dart';
import 'package:holmon/models/dto/product.dart';
import 'package:holmon/utils/myStates.dart';
import 'package:holmon/utils/dimensions.dart';
import 'package:holmon/views/common_widgets/appBar.dart';

import 'common_widgets/search_text_field.dart';

class Categories extends StatefulWidget {
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with AutomaticKeepAliveClientMixin {
  final ProductViewModel _productViewModel = Get.find<ProductViewModel>();

  ValueNotifier<String> _categories = ValueNotifier<String>('Categories ✨');

  int selectedCategoryIndex = 0;

  //final LocalizationController _localizationController = Get.put(LocalizationController());

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 6), () {
      _categories.value = 'Vegetables, fruits, dairy...';
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MyAppBar(
          title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SearchTextField(
          hint: _categories.value,
          readOnly: true,
        ),
      )),
      body: Obx(
        () {
          if (_productViewModel.currentState is LoadedState) {
            return Row(
              children: [
                Container(
                  width: 100,
                  margin: const EdgeInsets.only(left: 16),
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Get.theme.cardColor,
                  ),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: CategorieViewModel.categoriesMockup.length,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      Categorie category =
                          CategorieViewModel.categoriesMockup[index];
                      return InkWell(
                        onTap: () {
                          selectedCategoryIndex = index;
                          _productViewModel.getAllProductList(1);
                        },
                        child: CategoryItem(
                          title: category.name,
                          icon: category.imagefrontsmallurl,
                          isSelected: selectedCategoryIndex == index,
                        ),
                      );
                    },
                  ),
                ),
                // Product List
                // Product List
                Expanded(
                  child: GetBuilder<ProductViewModel>(
                    builder: (productViewModel) {
                      if (productViewModel.currentState is LoadingState) {
                        return const CircularProgressIndicator();
                      } else if (productViewModel.currentState is LoadedState) {
                        final productList =
                            (productViewModel.currentState as LoadedState).data;
                        return ListView.builder(
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            final Product product = productList[index];
                            return ExpansionTile(
                                shape: Border.all(color: Colors.transparent),
                                title: Text(
                                  product.productname.toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
                                children: [
                                  ListTile(
                                    onTap: () => {
                                      Get.toNamed("/details",
                                          arguments: product)
                                    },
                                    leading: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffE9F5FA)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: product.imagefrontsmallurl!,
                                          width: 40,
                                          height: 40,
                                          filterQuality: FilterQuality.none,
                                          //fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    /*trailing:
                                        const Icon(Icons.keyboard_arrow_right),*/
                                  ),
                                ]);
                            //return ProductItem(product: product);
                          },
                        );
                      } else if (productViewModel.currentState
                          is FailureState) {
                        final message =
                            (productViewModel.currentState as FailureState)
                                .error;
                        return Center(
                          child: Text('Error: $message'),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CategoryItem extends StatelessWidget {
  final String? title;
  final String? icon;
  final bool isSelected;

  const CategoryItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      /*margin: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraSmall, horizontal: 2),*/
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: isSelected
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).cardColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Get.theme.cardColor.withOpacity(0.05)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  '$icon',
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeExtraSmall),
                child: Text(
                  title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: isSelected
                        ? Get.theme.primaryColor
                        : Get
                            .theme.bottomNavigationBarTheme.unselectedItemColor,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
