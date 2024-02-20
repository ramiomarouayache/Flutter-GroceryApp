import 'dart:convert';

class Categorie {
  String? id;
  String? name;
  String? imagefrontsmallurl;

  Categorie({
    this.id,
    this.name,
    this.imagefrontsmallurl,
  });

  // ---------------------------------------------------------------------------
  // JSON
  // ---------------------------------------------------------------------------
  factory Categorie.fromRawJson(String str) =>
      Categorie.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  // ---------------------------------------------------------------------------
  // Maps
  // ---------------------------------------------------------------------------

  factory Categorie.fromMap(Map<String, dynamic> json) {
    return Categorie(
        id: json['id'],
        name: json['name'],
        imagefrontsmallurl: json['image_front_small_url']);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['image_front_small_url'] = imagefrontsmallurl;
    return data;
  }
}
