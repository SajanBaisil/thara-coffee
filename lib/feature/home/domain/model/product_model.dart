import 'package:equatable/equatable.dart';
import 'package:thara_coffee/shared/extensions/on_json.dart';

class ProductData with EquatableMixin {
  List<ProductModel>? data;
  String? message;
  String? success;

  ProductData({this.data, this.message, this.success});

  ProductData.fromJson(Map<String, dynamic> newJson) {
    final json = newJson.jsonStringify();
    if (json['data'] != null) {
      data = <ProductModel>[];
      json['data'].forEach((v) {
        data!.add(ProductModel.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['success'] = success;
    return data;
  }

  @override
  List<Object?> get props => [
        data,
        message,
        success,
      ];
}

class ProductModel with EquatableMixin {
  String? companyId;
  String? id;
  String? image;
  String? name;
  List<String>? posCategIds;
  List<String>? posCategIdsNames;
  String? price;

  ProductModel(
      {this.companyId,
      this.id,
      this.image,
      this.name,
      this.posCategIds,
      this.posCategIdsNames,
      this.price});

  ProductModel.fromJson(Map<String, dynamic> newJson) {
    final json = newJson.jsonStringify();
    companyId = json['company_id'];
    id = json['id'];
    image = json['image'];
    name = json['name'];
    if (json['pos_categ_ids'] != null) {
      posCategIds = <String>[];
      json['pos_categ_ids'].forEach((v) {
        posCategIds!.add(v.toString());
      });
    }
    if (json['pos_categ_ids_names'] != null) {
      posCategIdsNames = <String>[];
      json['pos_categ_ids_names'].forEach((v) {
        posCategIdsNames!.add(v.toString());
      });
    }
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_id'] = companyId;
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    if (posCategIds != null) {
      data['pos_categ_ids'] = posCategIds!;
    }
    if (posCategIdsNames != null) {
      data['pos_categ_ids_names'] = posCategIdsNames!;
    }
    data['price'] = price;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        companyId,
        id,
        image,
        name,
        posCategIds,
        posCategIdsNames,
        price,
      ];
}
