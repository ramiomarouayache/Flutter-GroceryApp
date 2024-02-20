import 'package:holmon/models/dto/cart.dart';
import 'package:holmon/models/source/local/cart_local_storage.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalStorage _cartLocalStorage;

  CartRepositoryImpl({
    required CartLocalStorage cartLocalStorage,
  }) : _cartLocalStorage = cartLocalStorage;

  @override
  CartItem? getCartItemById({required BigInt productId}) {
    final cachedCartItem =
        _cartLocalStorage.loadCartItem(cartItemId: productId);
    return cachedCartItem!;
  }

  @override
  Future<CartItem> insertCartItem(CartItem cartItem) async {
    _cartLocalStorage.saveCartItem(cartItem: cartItem);
    return cartItem;
  }

  @override
  List<CartItem> getCartItemList() {
    final cachedCartItemList = _cartLocalStorage.loadCartItemList();
    return cachedCartItemList ?? [];
  }

  @override
  Future<bool> removeCartItem({required CartItem cartItem}) async {
    return _cartLocalStorage.removeCartItem(cartItem: cartItem);
  }

  @override
  Future<CartItem> updateCartItem(CartItem cartItem) {
    throw UnimplementedError();
  }

  @override
  Future<bool> saveCartItemList(List<CartItem> cartItemList) {
    return _cartLocalStorage.saveCartItemList(cartItemList);
  }
}

abstract class CartRepository {
  Future<CartItem> insertCartItem(CartItem cartItem);
  Future<CartItem> updateCartItem(CartItem cartItem);
  Future<bool> removeCartItem({required CartItem cartItem});
  CartItem? getCartItemById({required BigInt productId});
  List<CartItem> getCartItemList();
  Future<bool> saveCartItemList(List<CartItem> cartItemList);
}
