import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app1/screens/splash_screen.dart';

import 'package:wallpaper_app1/screens/wallpaper_list/bloc/wallpaper_list_bloc.dart';
import 'package:wallpaper_app1/screens/wallpaper_page.dart';

import 'api/api_helper.dart';
import 'bloc/wallpaper_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => WallpaperBloc(apiHelper: ApiHelper()),
      ),
      BlocProvider(
        create: (context) => WallpaperListBloc(apiHelper: ApiHelper()),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallpaper App',
      theme: ThemeData(primaryColor: Colors.deepPurple),
      home:  WallpaperPage(),
    );
  }
}
