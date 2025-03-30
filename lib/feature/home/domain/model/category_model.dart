import 'package:equatable/equatable.dart';
import 'package:thara_coffee/shared/extensions/on_json.dart';

class CategoryModel with EquatableMixin {
  List<CategoryData>? data;
  String? message;
  String? status;
  String? success;

  CategoryModel({this.data, this.message, this.status, this.success});

  CategoryModel.fromJson(Map<String, dynamic> newJson) {
    final json = newJson.jsonStringify();
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(CategoryData.fromJson(v));
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

class CategoryData with EquatableMixin {
  String? id;
  String? image;
  String? name;
  String? parentId;
  String? parentName;

  CategoryData(
      {this.id, this.image, this.name, this.parentId, this.parentName});

  CategoryData.fromJson(Map<String, dynamic> newJson) {
    final json = newJson.jsonStringify();
    id = json['id'];
    image = json['image'];
    name = json['name'];
    parentId = json['parent_id'];
    parentName = json['parent_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['parent_id'] = parentId;
    data['parent_name'] = parentName;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        image,
        name,
        parentId,
        parentName,
      ];
}
