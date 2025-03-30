import 'package:equatable/equatable.dart';
import 'package:thara_coffee/shared/extensions/on_json.dart';

class LoginResponse with EquatableMixin {
  String? id;
  String? name;
  String? street;
  String? street2;
  String? city;
  String? zip;
  String? email;
  String? mobile;

  LoginResponse(
      {this.id,
      this.name,
      this.street,
      this.street2,
      this.city,
      this.zip,
      this.email,
      this.mobile});

  LoginResponse.fromJson(Map<String, dynamic> newJson) {
    final json = newJson.jsonStringify();
    id = json['id'];
    name = json['name'];
    street = json['street'];
    street2 = json['street2'];
    city = json['city'];
    zip = json['zip'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['street'] = street;
    data['street2'] = street2;
    data['city'] = city;
    data['zip'] = zip;
    data['email'] = email;
    data['mobile'] = mobile;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        street,
        street2,
        city,
        zip,
        email,
        mobile,
      ];
}
