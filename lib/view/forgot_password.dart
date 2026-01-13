import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:quadleo_project/bloc/auth/auth_bloc.dart';
import 'package:quadleo_project/bloc/auth/auth_event.dart';
import 'package:quadleo_project/decoration/decoration.dart';

class ForgotPasswordPage extends StatelessWidget {
   ForgotPasswordPage({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color(0xffF5F7FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Gap(40),

              
              textStyle("Forgot Password", 28, FontWeight.bold, Colors.black),

              

              Gap(12),
               textStyle("Enter your email and we will send you a reset link",
                13, FontWeight.normal, Colors.black54),
              

             Gap(40),

              buildTextField(
                controller: emailController,
                hint: "Email",
                icon: Icons.alternate_email,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                      final email = emailController.text.trim();
                      log("Button clicked: $email");
                      context.read<AuthBloc>().add(ForgotPasswordRequest(email));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: textStyle(
                    "Send Reset Link",
                    18,FontWeight.bold,Colors.white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    
    );
  }
}