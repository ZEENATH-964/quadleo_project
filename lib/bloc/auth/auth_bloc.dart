import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadleo_project/bloc/auth/auth_event.dart';
import 'package:quadleo_project/bloc/auth/auth_state.dart';
import 'package:quadleo_project/data/service/service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
final AuthService authService;
  AuthBloc(this.authService) : super(AuthInitial()) {
    on<LoginRequest>((event, emit) async{
      emit(AuthLoading());
      try {
        final user=await authService.login(event.request);
        emit(AuthAuthenticated(user));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<RegisterRequest>((event,emit)async{
     emit(AuthLoading());
     try {
       await authService.register(event.request);
       emit(AuthSuccess());
     } catch (e) {
       emit(AuthError(e.toString()));
     }
    });

    on<ForgotPasswordRequest>((event,emit)async{
      emit(AuthLoading());
      try {
        await authService.resetPassword(event.email);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

  }
}