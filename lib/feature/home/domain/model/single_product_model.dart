import 'package:equatable/equatable.dart';
import 'package:thara_coffee/shared/extensions/on_json.dart';

class SingleProductData with EquatableMixin {
  List<SingleProduct>? data;
  String? message;
  String? status;
  String? success;

  SingleProductData({this.data, this.message, this.status, this.success});

  SingleProductData.fromJson(Map<String, dynamic> newJson) {
    final json = newJson.jsonStringify();
    if (json['data'] != null) {
      data = <SingleProduct>[];
      json['data'].forEach((v) {
        data!.add(SingleProduct.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    data['success'] = success;
    return data;
  }

  @override
  List<Object?> get props => [
        data,
        message,
        status,
        success,
      ];
}

class SingleProduct with EquatableMixin {
  String? categId;
  String? categName;
  String? companyId;
  String? description;
  String? id;
  String? image;
  String? name;
  String? price;

  SingleProduct(
      {this.categId,
      this.categName,
      this.companyId,
      this.description,
      this.id,
      this.image,
      this.name,
      this.price});

  SingleProduct.fromJson(Map<String, dynamic> newJson) {
    final json = newJson.jsonStringify();
    categId = json['categ_id'];
    categName = json['categ_name'];
    companyId = json['company_id'];
    description = json['description'];
    id = json['id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categ_id'] = categId;
    data['categ_name'] = categName;
    data['company_id'] = companyId;
    data['description'] = description;
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['price'] = price;
    return data;
  }

  @override
  List<Object?> get props => [
        categId,
        categName,
        companyId,
        description,
        id,
        image,
        name,
        price,
      ];
}
