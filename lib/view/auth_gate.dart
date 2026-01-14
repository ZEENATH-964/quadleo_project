import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadleo_project/bloc/auth/auth_bloc.dart';
import 'package:quadleo_project/bloc/auth/auth_state.dart';
import 'package:quadleo_project/view/login.dart';
import 'package:quadleo_project/view/productlist.dart';

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AuthAuthenticated) {
          return Productlist();
        }

        return Login();
      },
    );
  }
}
