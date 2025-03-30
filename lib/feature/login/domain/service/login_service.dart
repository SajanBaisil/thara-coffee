import 'package:thara_coffee/feature/login/domain/model/company_response.dart';
import 'package:thara_coffee/feature/login/domain/model/login_response.dart';
import 'package:thara_coffee/feature/login/domain/repository/login_repository.dart';
import 'package:thara_coffee/shared/domain/constants/endpoints.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/local_storage/local_storage_service.dart';
import 'package:thara_coffee/shared/router/global_setters.dart';
import 'package:thara_coffee/shared/router/http%20utils/common_exception.dart';
import 'package:thara_coffee/shared/router/http%20utils/http_helper.dart';

class LoginService extends LoginRepository {
  @override
  Future<LoginResponse> login(
      {required String name,
      required String mobile,
      required String companyId}) async {
    final data = {
      'name': name,
      'mobile': mobile,
      'company_id': companyId,
    };
    final response = await HttpHelper.getDataFromServer(
      Endpoints.customer,
      data: data,
    );
    final loginResponse = LoginResponse.fromJson(response.responseBody);
    if (!response.success) {
      throw ApiException(response.message, response.responseCode);
    }

    // // ignore: unnecessary_parenthesis
    // if ((loginResponse.data?.token).isNullOrEmpty) {
    //   throw ApiException(
    //     'Unable to authenticate you at the moment,Please try again later',
    //     response.responseCode,
    //   );
    // }

    // if (loginResponse.data?.mpinEnabled == 'true') {
    //else case only save to local after setting up mpin in mpin repository
    await setupAfterLogin(loginResponse: loginResponse);
    // }

    return loginResponse;
  }

  @override
  Future<void> setupAfterLogin({
    required LoginResponse loginResponse,
  }) async {
    try {
      await GlobalSetters.saveLoginResponseToLocal(loginResponse);
      await serviceLocator<LocalStorageService>().setFirstTimeRun();
    } catch (e) {
      throw ApiException(
        'Something went wrong while setting up your profile, Please try again',
        500,
      );
    }
  }

  @override
  Future<CompanyModel> getCompanyData() async {
    final response = await HttpHelper.getDataFromServer(
      Endpoints.company,
    );
    final companyResponse = CompanyModel.fromJson(response.responseBody);
    if (!response.success) {
      throw ApiException(response.message, response.responseCode);
    }
    return companyResponse;
  }
}
