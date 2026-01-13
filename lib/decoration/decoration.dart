import 'package:flutter/material.dart';

Widget textStyle(String text,double size,FontWeight fontweight,Color color){
  return Text(text,style: TextStyle(color: color,fontSize: size,fontWeight: fontweight),);
}


Widget buildTextField({
  required TextEditingController controller,
  required String hint,
  required IconData icon,
  bool isPassword=false,
  bool obscure=false,
  Widget? suffix
}){
  return Container(
    height: 55,
    padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 234, 233, 233),
      borderRadius: BorderRadius.circular(30)
    ),
    child: TextField(controller: controller,
    obscureText: obscure,
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: hint,
      prefixIcon: Icon(icon,),
      suffixIcon: suffix
    ),
    ),
  );
}

Widget actionContainer(
{required String text,
required VoidCallback onTap,
bool isOutlined=false

}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 55,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isOutlined?Colors.transparent:const Color.fromARGB(255, 234, 233, 233),
        borderRadius: BorderRadius.circular(30),
        border: isOutlined
            ? Border.all(
                color: Colors.black12,
                width: 1.5,
              ):null
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
