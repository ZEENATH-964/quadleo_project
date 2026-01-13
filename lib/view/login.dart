import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quadleo_project/decoration/decoration.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        title: Center(child:textStyle("Login", 23, FontWeight.bold,Colors.black)),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
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
                  onPressed: () {},
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
             actionContainer(text: "Forgot Password?", onTap: (){}),
              Gap(10),
            actionContainer(text: "Create Account",
            isOutlined: true,
             onTap: (){})
             
            ],),
          ),
        ),
      ),
    );
  }
}