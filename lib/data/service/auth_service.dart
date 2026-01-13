import 'package:firebase_auth/firebase_auth.dart';
import 'package:quadleo_project/data/model/login_model.dart';
import 'package:quadleo_project/data/model/register_model.dart';
import 'package:quadleo_project/data/model/user_model.dart';

class AuthService {
  final FirebaseAuth auth=FirebaseAuth.instance;

  Future<UserModel>login(LoginModel request)async{
final userCredencial=await auth.signInWithEmailAndPassword(
  
  email: request.email, 
  password: request.password);
  return UserModel.fromFirebase(userCredencial.user!);
  }


  Future<UserModel>register(RegisterModel request)async{
    final userCredencial=await auth.createUserWithEmailAndPassword(
      email: request.email,
       password: request.password);
       await userCredencial.user!.sendEmailVerification();
       return UserModel.fromFirebase(userCredencial.user!);
  }

  Future<void> logout() async {
  await auth.signOut();
}


  Future<void> resetPassword(String email) async {
  await auth.sendPasswordResetEmail(email: email);
}


}