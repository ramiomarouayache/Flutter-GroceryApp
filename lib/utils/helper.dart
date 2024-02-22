import 'package:get/get.dart';
import 'package:holmon/domain/cartViewModel.dart';
import 'package:holmon/domain/categorieViewModel.dart';
import 'package:holmon/domain/productViewModel.dart';
import 'package:holmon/models/product_repo_Impl.dart';
import 'package:holmon/models/shopingCart_repo_impl.dart';
import 'package:holmon/models/source/local/cart_local_storage.dart';
import 'package:holmon/models/source/local/product_local_storage.dart';
import 'package:holmon/models/source/remote/api.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:holmon/constants/appConstants.dart';

Future initDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => LocalStorageImpl(sharedPreferences: sharedPreferences));

  Get.lazyPut(() => ApiImpl(AppConstants.BASE_URL));

  Get.lazyPut(() => ProductRepositoryImpl(
        api: Get.find<ApiImpl>(),
        localStorage: Get.find<LocalStorageImpl>(),
      ));

  Get.lazyPut(() => ProductViewModel(
      productRepositoryImpl: Get.find<ProductRepositoryImpl>()));

  Get.lazyPut(() => CartLocalStorageImpl(sharedPreferences: sharedPreferences));

  Get.lazyPut(() => CartRepositoryImpl(
        cartLocalStorage: Get.find<CartLocalStorageImpl>(),
      ));

  Get.lazyPut(() => ShoppingCartViewModel(
      cartRepositoryImpl: Get.find<CartRepositoryImpl>()));

  Get.put(CategorieViewModel());

  //Get.put(SearchViewModel());

  //Get.put(MyGameController());
}

Future<LottieComposition?> customDecoder(List<int> bytes) {
  return LottieComposition.decodeZip(bytes, filePicker: (files) {
    return files.firstWhereOrNull(
        (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'));
  });
}
