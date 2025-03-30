import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thara_coffee/feature/login/domain/model/company_response.dart';
import 'package:thara_coffee/feature/login/domain/model/login_response.dart';
import 'package:thara_coffee/feature/login/domain/repository/login_repository.dart';
import 'package:thara_coffee/shared/components/datafetch_status.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/router/http%20utils/common_exception.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<ViewCompanyEvent>(_onViewCompanyEvent);
  }

  final _loginRepo = serviceLocator<LoginRepository>();

  void _onViewCompanyEvent(
    ViewCompanyEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(companyFetchStatus: DataFetchStatus.waiting));
    try {
      final response = await _loginRepo.getCompanyData();

      emit(state.copyWith(
          companyFetchStatus: DataFetchStatus.success, companyModel: response));
    } catch (e) {
      emit(state.copyWith(
          companyFetchStatus: DataFetchStatus.failed,
          errorMessage: e is ApiException
              ? e.message
              : 'Something went wrong please try again later'));
    }
  }

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(loginStatus: DataFetchStatus.waiting));
    try {
      final response = await _loginRepo.login(
          companyId: event.companyId,
          name: event.username,
          mobile: event.phoneNumber);
      emit(state.copyWith(
          loginStatus: DataFetchStatus.success, loginResponse: response));
    } catch (e) {
      emit(state.copyWith(
          loginStatus: DataFetchStatus.failed,
          errorMessage: e is ApiException
              ? e.message
              : 'Something went wrong please try again later'));
    }
  }
}
