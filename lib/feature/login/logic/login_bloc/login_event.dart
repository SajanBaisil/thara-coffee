part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String phoneNumber;
  final String companyId;

  const LoginButtonPressed(
      {required this.username,
      required this.phoneNumber,
      required this.companyId});

  @override
  List<Object> get props => [username, phoneNumber, companyId];
}

class ViewCompanyEvent extends LoginEvent {}
