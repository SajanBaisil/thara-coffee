part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.loginStatus = DataFetchStatus.idle,
    this.errorMessage = '',
    this.loginResponse,
    this.companyModel,
    this.companyFetchStatus = DataFetchStatus.idle,
  });
  final DataFetchStatus loginStatus;
  final String errorMessage;
  final LoginResponse? loginResponse;
  final CompanyModel? companyModel;
  final DataFetchStatus companyFetchStatus;
  @override
  List<Object?> get props => [
        loginStatus,
        errorMessage,
        loginResponse,
        companyModel,
        companyFetchStatus,
      ];

  LoginState copyWith({
    DataFetchStatus? loginStatus,
    String? errorMessage,
    LoginResponse? loginResponse,
    CompanyModel? companyModel,
    DataFetchStatus? companyFetchStatus,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      loginResponse: loginResponse ?? this.loginResponse,
      companyModel: companyModel ?? this.companyModel,
      companyFetchStatus: companyFetchStatus ?? this.companyFetchStatus,
    );
  }
}
