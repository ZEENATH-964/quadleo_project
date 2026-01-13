import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadleo_project/bloc/auth/auth_bloc.dart';
import 'package:quadleo_project/bloc/auth/auth_state.dart';
import 'package:quadleo_project/view/login.dart';
import 'package:quadleo_project/view/productlist.dart';

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print("STATE: $state");

        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) =>
                const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AuthAuthenticated) {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => Productlist()),
            (route) => false,
          );
        }

        if (state is AuthSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Check your email")),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) =>  Login()),
            (route) => false,
          );
        }

        if (state is AuthInitial) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) =>  Login()),
            (route) => false,
          );
        }

        if (state is AuthError) {
          Navigator.of(context, rootNavigator: true).pop();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: FirebaseAuth.instance.currentUser == null
          ? const Login()
          : const Productlist(),
    );
  }
}
