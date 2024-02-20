/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
import 'dart:convert';
import 'dart:math';

class Product {
  String? categories;
  String? id;
  String? imagefrontsmallurl;
  String? imagefronturl;
  String? imagenutritionurl;
  String? manufacturingplaces;
  String? productname;
  String? quantity;
  String? stores;
  final String? price;
  final String? regularPrice;
  final String? discount;

  Product(
      {this.categories,
      this.id,
      this.imagefrontsmallurl,
      this.imagefronturl,
      this.imagenutritionurl,
      this.manufacturingplaces,
      this.productname,
      this.quantity,
      this.stores,
      this.price,
      this.regularPrice,
      this.discount});

  // ---------------------------------------------------------------------------
  // JSON
  // ---------------------------------------------------------------------------
  factory Product.fromRawJson(String str) => Product.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  // ---------------------------------------------------------------------------
  // Maps
  // ---------------------------------------------------------------------------

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      categories: json['categories'],
      id: json['id'],
      imagefrontsmallurl: json['image_front_small_url'],
      imagefronturl: json['image_front_url'],
      imagenutritionurl: json['image_nutrition_url'],
      manufacturingplaces: json['manufacturing_places'],
      productname: json['product_name'],
      quantity: json['quantity'],
      stores: json['stores'],
      price: json['price'] ??
          (Random().nextDouble() * (100 - 5) + 5).toStringAsFixed(2) + "da",
      regularPrice: json['regularPrice'] ??
          (Random().nextDouble() * (150 - 40) + 40).toStringAsFixed(2) + "da",
      discount:
          json['discount'] ?? (Random().nextInt(51) + 10).toString() + "%",
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['categories'] = categories;
    data['id'] = id;
    data['image_front_small_url'] = imagefrontsmallurl;
    data['image_front_url'] = imagefronturl;
    data['image_nutrition_url'] = imagenutritionurl;
    data['manufacturing_places'] = manufacturingplaces;
    data['product_name'] = productname;
    data['quantity'] = quantity;
    data['stores'] = stores;
    data['price'] = price ??
        (Random().nextDouble() * (100 - 5) + 5).toStringAsFixed(2) + "da";
    data['regularPrice'] = regularPrice ??
        (Random().nextDouble() * (150 - 40) + 40).toStringAsFixed(2) + "da";
    data['discount'] = discount ?? (Random().nextInt(51) + 10).toString() + "%";
    return data;
  }
}
