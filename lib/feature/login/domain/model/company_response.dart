import 'package:equatable/equatable.dart';
import 'package:thara_coffee/shared/extensions/on_json.dart';

class CompanyModel with EquatableMixin {
  List<CompanyData>? data;
  String? message;
  String? status;
  String? success;

  CompanyModel({this.data, this.message, this.status, this.success});

  CompanyModel.fromJson(Map<String, dynamic> newJson) {
    final json = newJson.jsonStringify();
    if (json['data'] != null) {
      data = <CompanyData>[];
      json['data'].forEach((v) {
        data!.add(CompanyData.fromJson(v));
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

class CompanyData with EquatableMixin {
  String? address;
  String? city;
  String? countryId;
  String? email;
  String? id;
  String? name;
  String? phone;
  String? website;

  CompanyData(
      {this.address,
      this.city,
      this.countryId,
      this.email,
      this.id,
      this.name,
      this.phone,
      this.website});

  CompanyData.fromJson(Map<String, dynamic> newJson) {
    final json = newJson.jsonStringify();
    address = json['address'];
    city = json['city'];
    countryId = json['country_id'];
    email = json['email'];
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['city'] = city;
    data['country_id'] = countryId;
    data['email'] = email;
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['website'] = website;
    return data;
  }

  @override
  List<Object?> get props => [
        address,
        city,
        countryId,
        email,
        id,
        name,
        phone,
        website,
      ];
}
