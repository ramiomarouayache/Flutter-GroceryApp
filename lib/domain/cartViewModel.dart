import 'dart:async';
import 'package:get/get.dart';
import 'package:holmon/models/dto/cart.dart';
import 'package:holmon/models/shopingCart_repo_impl.dart';
import 'package:rxdart/rxdart.dart' as reactive;

class ShoppingCartViewModel extends GetxController {
  CartRepository _cartRepository;
  ShoppingCartViewModel({required CartRepository cartRepositoryImpl})
      : _cartRepository = cartRepositoryImpl;

  final _cartController = reactive.BehaviorSubject<int>.seeded(0);
  Stream<int> get cartUpdates => _cartController.stream;
  RxMap<String, CartItem> _productCartMap = Map<String, CartItem>().obs;
  Map<String, CartItem> get productCartMap => _productCartMap;

  void dispose() async {
    _cartController.close();
    super.dispose();
  }

  @override
  void onClose() async {
    super.onClose();
  }

  void _updateCartLength() {
    _cartController.value = _productCartMap.length;
  }

  Future<void> addToCart(CartItem cartItem) async {
    try {
      if (_productCartMap.values.contains(cartItem)) {
        if (cartItem.itemQuantity < 8) {
          cartItem.itemQuantity += 1;
        }
        _productCartMap.update(cartItem.id!, (value) => cartItem);
        _updateCartLength();
      } else {
        _productCartMap.putIfAbsent(cartItem.id.toString(), () => cartItem);
        _updateCartLength();
      }
    } catch (e) {
      print('Error adding to data in viewModel: $e');
    }
  }

  Future<void> removeFromCart(CartItem cartItem) async {
    try {
      if (_productCartMap.values.contains(cartItem) &&
          cartItem.itemQuantity > 1) {
        cartItem.itemQuantity -= 1;
        _productCartMap.update(cartItem.id.toString(), (value) => cartItem);
        _updateCartLength();
      } else {
        _productCartMap.removeWhere((key, value) => value == cartItem);
        _updateCartLength();
      }
    } catch (e) {
      print('Error removing cartItem in viewModel: $e');
    }
  }

  List<CartItem> getCartItemList() {
    final cartItemList = _cartRepository.getCartItemList();
    if (cartItemList.isNotEmpty) {
      _productCartMap.assignAll(
        Map.fromIterable(
          cartItemList,
          key: (cartItem) => cartItem.id.toString(),
          value: (cartItem) => cartItem,
        ),
      );
      _updateCartLength();
      return cartItemList;
    }
    return [];
  }

  Future<void> persistCartItems() async {
    try {
      await _cartRepository.saveCartItemList(_productCartMap.values.toList());
    } catch (e) {
      print('Error saving cart items: $e');
    }
  }
}
