import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadleo_project/bloc/auth/auth_bloc.dart';
import 'package:quadleo_project/bloc/auth/auth_event.dart';
import 'package:quadleo_project/decoration/decoration.dart';

class Productlist extends StatelessWidget {
  const Productlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Center(child: textStyle("Products", 23, FontWeight.bold, Colors.black)),
      actions: [
        IconButton(onPressed: (){
          context.read<AuthBloc>().add(LogoutRequested());
        }, icon: Icon(Icons.logout))
      ],
    ),);
  }
}