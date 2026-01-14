import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:quadleo_project/bloc/auth/auth_bloc.dart';
import 'package:quadleo_project/bloc/auth/auth_event.dart';
import 'package:quadleo_project/bloc/auth/auth_state.dart';
import 'package:quadleo_project/data/model/login_model.dart';
import 'package:quadleo_project/decoration/decoration.dart';
import 'package:quadleo_project/view/forgot_password.dart';
import 'package:quadleo_project/view/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final emailController =TextEditingController();
  final passwordController=TextEditingController();
  bool isPasswordVisible=false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.message)));
    }
  },
   child:   Scaffold(
        appBar: AppBar(
        title: Center(child:textStyle("Login", 23, FontWeight.bold,Colors.black)),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                 textStyle("Welcome back!", 30, FontWeight.bold,Colors.black),
                
                 Gap(50),
                 buildTextField(
                  controller: emailController,
                   hint: "Email",
                    icon: Icons.alternate_email,
                    
                    ),
                    Gap(10),
                    buildTextField(
                      controller: passwordController,
                       hint: "Password",
                        icon: Icons.lock_outlined,
                        isPassword: true,
                        suffix: IconButton(onPressed: (){
                          setState(() {
                            isPasswordVisible=!isPasswordVisible;
                          });
                        },
                         icon: Icon(
                          isPasswordVisible?Icons.visibility_off:Icons.visibility,color: const Color.fromARGB(255, 118, 118, 118),
                         )),
                         obscure: !isPasswordVisible
                        ),
                        Gap(40),
                SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        final email=emailController.text.trim();
                        final password=passwordController.text.trim();
                        context.read<AuthBloc>().add(LoginRequest(LoginModel(email: email, password: password)));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 3, 48, 145),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: textStyle("Sign In", 20, FontWeight.bold, Colors.white)
                    ),
                  ),
                
                  Gap(20),
                 actionContainer(text: "Forgot Password?", onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ForgotPasswordPage()));
                 }),
                  Gap(10),
                actionContainer(text: "Create Account",
                isOutlined: true,
                 onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Register()));
                 })
                 
                ],),
              ),
            ),
          ),
        ),
   ) 
    );
  }
}