import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/network/local/cache_helper.dart';
import 'package:social/view/screens/create_new_post/creat_new_post_cubit.dart';
import 'package:social/view/screens/create_story/creat_story_cubit.dart';
import 'package:social/view/screens/home/home_screen.dart';
import 'package:social/view/screens/login/login_cubit.dart';
import 'package:social/view/screens/login/login_screen.dart';
import 'package:social/view/screens/messages_screen/messages_cubit.dart';
import 'package:social/view/screens/new_feeds/new_feeds_cubit.dart';
import 'package:social/view/screens/profile_screen/profile_cubit.dart';
import 'package:social/view/screens/register/regester_screen.dart';
import 'package:social/view/screens/register/register_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCEmOoLQuxRRVkyuf6Y_wrKxKtniF7M6zg",
        //authDomain: "xxxx",
        projectId: "social-26c20",
        //storageBucket: "xxx",
        messagingSenderId: "xxxxx",
        appId: "531298500732"),
  );
  await FirebaseAppCheck.instance.activate();

  uId = CacheHelper.getData(key: 'uId');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit()..getUserData(),
        ),
        BlocProvider(
          create: (context) => NewFeedsCubit()
            ..getPost()
            ..getAllUsers(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => CreatePostCubit(),
        ),
        BlocProvider(
          create: (context) => MessagesCubit(),
        ),
        BlocProvider(
          create: (context) => CreateStoryCubit()..getStories(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        routes: {
          'register': (context) => RegisterScreen(),
          'login': (context) => LoginScreen(),
          'home': (context) => HomeScreen(),
        },
      ),
    );
  }
}
