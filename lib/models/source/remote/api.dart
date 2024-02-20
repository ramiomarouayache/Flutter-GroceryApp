import 'package:dio/dio.dart';
import 'package:holmon/models/dto/product.dart';

abstract class Api {
  //interface is depend on your api endpoints, your needs...etc
  Api(String appBaseUrl);
  Future<List<Product>> loadProductList({required int page});
  Future<Product> loadProductById({required BigInt id});
}

//Implemntaion depend on your api documentaion
class ApiImpl implements Api {
  final Dio dio;
  final String appBaseUrl;

  ApiImpl(this.appBaseUrl) : dio = Dio(BaseOptions(baseUrl: appBaseUrl));

  @override
  Future<List<Product>> loadProductList({required int page}) async {
    try {
      Response response;
      response = await dio.get(appBaseUrl, queryParameters: {'page': page});

      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));

      final l = (response.data['products'] as List)
          .map((e) => Product.fromMap(e))
          .where((element) =>
              element.imagefrontsmallurl != null &&
              element.imagefronturl != null &&
              element.productname != null &&
              element.id != null &&
              element.productname!.isNotEmpty)
          .toList();
      print("api return " + l.toString());
      return l;
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);

        //  API responds with 404 when reached the end
        if (e.response?.statusCode == 404) return [];
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }

    return [];
  }

  @override
  Future<Product> loadProductById({required BigInt id}) async {
    try {
      Response response;
      response = await dio.get(appBaseUrl, queryParameters: {'id': id});

      // Assuming 'results' is a list in the response
      final results = response.data['results'] as List;

      // Assuming 'results' contains a single item
      if (results.isNotEmpty) {
        final jsonProduct = results.first;
        return Product.fromRawJson(jsonProduct);
      } else {
        // Return a default or handle the case when 'results' is empty
        return Product(); // Adjust this line based on your Product class
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);

        //  API responds with 404 when reached the end
        //if (e.response?.statusCode == 404) return l;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
    throw UnimplementedError();
  }
}
