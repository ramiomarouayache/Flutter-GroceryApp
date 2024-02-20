import 'package:flutter/foundation.dart';
import 'package:holmon/models/dto/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cachedCartItemListKey = 'CACHED_CART_ITEM_LIST';

abstract class CartLocalStorage {
  Future<bool> saveCartItem({required CartItem cartItem});
  Future<bool> removeCartItem({required CartItem cartItem});
  List<CartItem>? loadCartItemList();
  CartItem? loadCartItem({required BigInt cartItemId});

  Future<bool> updateCartItem({required CartItem cartItem});
  Future<bool> saveCartItemList(List<CartItem> cartItemList);
}

class CartLocalStorageImpl implements CartLocalStorage {
  final SharedPreferences _sharedPref;
  final String _key;

  CartLocalStorageImpl({
    required SharedPreferences sharedPreferences,
  })  : _sharedPref = sharedPreferences,
        _key = cachedCartItemListKey;

  @visibleForTesting
  static String getKeyToList(int page) {
    return '${cachedCartItemListKey}_$page';
  }

  @override
  List<CartItem>? loadCartItemList() {
    final jsonList = _sharedPref.getStringList(_key);
    return jsonList?.map((e) => CartItem.fromRawJson(e)).toList();
  }

  @override
  Future<bool> removeCartItem({required CartItem cartItem}) async {
    final jsonCartItems = _sharedPref.getStringList(_key);

    final removedItems = jsonCartItems
        ?.map((e) => CartItem.fromRawJson(e))
        .where((element) => element == cartItem)
        .toList(); // Convert the iterable to a list

    if (removedItems != null && removedItems.isNotEmpty) {
      jsonCartItems
          ?.removeWhere((element) => element == removedItems[0].toRawJson());
      _sharedPref.setStringList(_key, jsonCartItems!);
      return true;
    }

    return false;
  }

  @override
  Future<bool> saveCartItem({required CartItem cartItem}) async {
    final jsonList = _sharedPref.getStringList(_key) ?? [];
    jsonList.add(cartItem.toRawJson());
    return _sharedPref.setStringList(_key, jsonList);
  }

  @override
  CartItem? loadCartItem({required BigInt cartItemId}) {
    final jsonCartItems = _sharedPref.getStringList(_key);

    if (jsonCartItems != null) {
      try {
        return jsonCartItems.map((e) => CartItem.fromRawJson(e)).firstWhere(
            (element) => element.id == cartItemId.toString(),
            orElse: () => CartItem(
                id: "",
                imagefrontsmallurl: "",
                imagefronturl: "",
                productname: "",
                itemQuantity: 0,
                quantity: '',
                price: '',
                categories: ''));
      } catch (e) {
        return null;
      }
    }

    return null;
  }

  @override
  Future<bool> updateCartItem({required CartItem cartItem}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> saveCartItemList(List<CartItem> cartItemList) {
    final jsonList = cartItemList.map((e) => e.toRawJson()).toList();
    return _sharedPref.setStringList(_key, jsonList);
  }
}
