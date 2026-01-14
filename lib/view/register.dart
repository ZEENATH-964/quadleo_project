import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:quadleo_project/bloc/auth/auth_bloc.dart';
import 'package:quadleo_project/bloc/auth/auth_event.dart';
import 'package:quadleo_project/bloc/auth/auth_state.dart';
import 'package:quadleo_project/data/model/register_model.dart';
import 'package:quadleo_project/decoration/decoration.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final confirmPasswordController=TextEditingController();
  bool isConformVisible=false;
  bool isPasswordVisible=false;
  @override
  Widget build(BuildContext context) {
    return
    BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthLoading) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) =>
             Center(child: CircularProgressIndicator()),
      );
    }

    if (state is AuthSuccess) {
      Navigator.pop(context); // loader close
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("Registration successful. Please login")),
      );
      Navigator.pop(context); // back to Login
    }

    if (state is AuthError) {
      Navigator.pop(context); // loader close
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.message)));
    }
  },
  child:   Scaffold(
      appBar: AppBar(
        title: Center(child: textStyle("Register", 20, FontWeight.bold, Colors.black)),
      ),
      body: SafeArea(
        child: Center(child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTextField(
                  controller: emailController, 
                  hint: "Email",
                   icon: Icons.alternate_email),
                   Gap(10),
                   buildTextField(controller: passwordController, 
                   hint: "Password",
                    icon: Icons.lock_outline,
                    obscure: !isPasswordVisible,
                    suffix: IconButton(
                      onPressed: (){
                        setState(() {
                          isPasswordVisible=!isPasswordVisible;
                        });
                      }, 
                      icon: Icon(isPasswordVisible?Icons.visibility_off:Icons.visibility,color: const Color.fromARGB(255, 118, 118, 118),))
                    ),
                    Gap(10),
                    buildTextField(controller: confirmPasswordController, 
                   hint: "Conform Password",
                    icon: Icons.lock_outline,
                    obscure: !isConformVisible,
                    suffix: IconButton(
                      onPressed: (){
                        setState(() {
                          isConformVisible=!isConformVisible;
                        });
                      }, 
                      icon: Icon(isPasswordVisible?Icons.visibility_off:Icons.visibility,color: const Color.fromARGB(255, 118, 118, 118),))
                    ),
                    
                    Gap(80),
                    SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                       final email = emailController.text.trim();
                       final password = passwordController.text.trim();
                       final confirm = confirmPasswordController.text.trim();
                        if (password != confirm) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Passwords do not match")),
                );
                return;
              }
              context.read<AuthBloc>().add(RegisterRequest(RegisterModel(email: email, password: password)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 35, 125, 38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: textStyle("Sign Up", 20, FontWeight.bold, Colors.white)
                  ),
                ),
              ],),
          ),
        )),
      ),
  )
    );
    
  }
}