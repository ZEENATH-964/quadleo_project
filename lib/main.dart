import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadleo_project/bloc/auth/auth_bloc.dart';
import 'package:quadleo_project/data/service/auth_service.dart';
import 'package:quadleo_project/firebase_options.dart';
import 'package:quadleo_project/view/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


 @override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (_) => AuthBloc(AuthService()),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate()
    ),
  );
}

}
