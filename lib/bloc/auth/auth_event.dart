import 'package:equatable/equatable.dart';
import 'package:quadleo_project/data/model/login_model.dart';
import 'package:quadleo_project/data/model/register_model.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?>get props=>[];

  
}

class LoginRequest extends AuthEvent {
  final LoginModel request;
  LoginRequest(this.request);
  @override
  List<Object?>get props=>[request];
}


class RegisterRequest extends AuthEvent {
  final RegisterModel request;
  RegisterRequest(this.request);
  @override
  List<Object?>get props=>[request];
}

class LogoutRequested extends AuthEvent {}


class ForgotPasswordRequest extends AuthEvent {
  final String email;
  ForgotPasswordRequest(this.email);
  @override
  List<Object?>get props=>[email];
}