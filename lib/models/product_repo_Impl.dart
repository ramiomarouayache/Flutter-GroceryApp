import 'package:holmon/models/dto/product.dart';
import 'package:holmon/models/source/local/product_local_storage.dart';
import 'package:holmon/models/source/remote/api.dart';

class ProductRepositoryImpl implements ProductRepository {
  final Api _api;
  final LocalStorage _localStorage;

  ProductRepositoryImpl({
    required Api api,
    required LocalStorage localStorage,
  })  : _api = api,
        _localStorage = localStorage;

  @override
  Future<List<Product>> getAllProductList({required int page}) async {
    final cachedList = _localStorage.loadProductList(page: page);
    if (cachedList.isNotEmpty) {
      return cachedList;
    }

    final fetchedList = await _api.loadProductList(page: page);
    await _localStorage.saveProductList(page: page, list: fetchedList);

    return fetchedList;
  }

  @override
  Future<Product?> getProductByid({required BigInt id}) async {
    final cachedProduct = _localStorage.loadProductById(id: id);
    if (cachedProduct != null) {
      return cachedProduct;
    }

    final fetchedProduct = await _api.loadProductById(id: id);
    await _localStorage.saveProductById(id: id, product: fetchedProduct);
    return fetchedProduct;
  }

  Product? removeProductByid({required BigInt id}) {
    return _localStorage.removeProductById(id: id) ?? null;
  }
}

abstract class ProductRepository {
  Future<List<Product>> getAllProductList({required int page});
  Future<Product?> getProductByid({required BigInt id});
}
