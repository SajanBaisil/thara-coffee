import 'package:thara_coffee/feature/login/domain/model/company_response.dart';
import 'package:thara_coffee/feature/login/domain/model/login_response.dart';

abstract class LoginRepository {
  Future<LoginResponse> login(
      {required String name,
      required String mobile,
      required String companyId});
  Future<void> setupAfterLogin({
    required LoginResponse loginResponse,
  });

  Future<CompanyModel> getCompanyData();
}
