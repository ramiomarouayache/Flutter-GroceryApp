import 'package:flutter/foundation.dart';
import 'package:holmon/models/dto/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cachedCharacterListKey = 'CACHED_CHARACTER_LIST_PAGE';
const cachedProductKey = 'CACHED_PRODUCT';

abstract class LocalStorage {
  Future<bool> saveProductList({
    required int page,
    required List<Product> list,
  });
  Future<bool> saveProductById({
    required BigInt id,
    required Product product,
  });
  Product? removeProductById({
    required BigInt id,
  });
  List<Product> loadProductList({required int page});
  Product? loadProductById({required BigInt id});
}

class LocalStorageImpl implements LocalStorage {
  final SharedPreferences _sharedPref;

  LocalStorageImpl({
    required SharedPreferences sharedPreferences,
  }) : _sharedPref = sharedPreferences;

  @override
  List<Product> loadProductList({required int page}) {
    final key = getKeyToPage(page);
    final jsonList = _sharedPref.getStringList(key);

    return jsonList != null
        ? jsonList.map((e) => Product.fromRawJson(e)).toList()
        : [];
  }

  @override
  Future<bool> saveProductList({
    required int page,
    required List<Product> list,
  }) {
    final jsonList = list.map((e) => e.toRawJson()).toList();
    final key = getKeyToPage(page);
    return _sharedPref.setStringList(key, jsonList);
  }

  @visibleForTesting
  static String getKeyToPage(int page) {
    return '${cachedCharacterListKey}_$page';
  }

  @override
  Future<bool> saveProductById({required BigInt id, required Product product}) {
    final jsonProduct = product.toRawJson();
    final key = getKeyProduct(id);
    return _sharedPref.setString(key, jsonProduct);
  }

  @visibleForTesting
  static String getKeyProduct(BigInt id) {
    return '${cachedProductKey}_$id';
  }

  @override
  Product? loadProductById({required BigInt id}) {
    final key = getKeyProduct(id);
    final jsonProduct = _sharedPref.getString(key);

    return jsonProduct != null ? Product.fromRawJson(jsonProduct) : null;
  }

  @override
  Product? removeProductById({required BigInt id}) {
    final key = getKeyProduct(id);
    final jsonProduct = _sharedPref.getString(key);
    _sharedPref.remove(key);
    return jsonProduct != null ? Product.fromRawJson(jsonProduct) : null;
  }
}
