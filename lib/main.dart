import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_hub/core/di/di.dart';
import 'package:food_hub/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food_hub/features/auth/presentation/screen/register_screen.dart';
import 'package:food_hub/features/home/presentation/cubit/home_cubit.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthCubit>()..loadCurrentUser(),
        ),
        BlocProvider(
          create: (_) => getIt<HomeCubit>()..getHome(),
        ),
      ],
      child: MaterialApp(
        title: 'Food Hub',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: RegisterScreen(),
      ),
    );
  }
}

