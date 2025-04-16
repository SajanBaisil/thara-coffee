import 'package:equatable/equatable.dart';
import 'package:thara_coffee/shared/extensions/on_json.dart';

class LoginResponse with EquatableMixin {
  String? city;
  String? companyId;
  String? country;
  String? email;
  String? id;
  String? mobile;
  String? name;
  String? state;
  String? street;
  String? street2;
  String? zip;

  LoginResponse(
      {this.id,
      this.name,
      this.state,
      this.street,
      this.street2,
      this.city,
      this.companyId,
      this.country,
      this.zip,
      this.email,
      this.mobile});

  LoginResponse.fromJson(Map<String, dynamic> newJson) {
    final json = newJson.jsonStringify();
    city = json['city'];
    companyId = json['company_id'];
    country = json['country'];
    email = json['email'];
    id = json['id'];
    mobile = json['mobile'];
    name = json['name'];
    state = json['state'];
    street = json['street'];
    street2 = json['street2'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['company_id'] = companyId;
    data['country'] = country;
    data['email'] = email;
    data['id'] = id;
    data['mobile'] = mobile;
    data['name'] = name;
    data['state'] = state;
    data['street'] = street;
    data['street2'] = street2;
    data['zip'] = zip;
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
        companyId,
        country,
        state,
      ];
}
