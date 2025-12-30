import 'package:ats_friendly_cv_maker_app/home_page.dart';
import 'package:ats_friendly_cv_maker_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/resume_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final resumeProvider = ResumeProvider();
  await resumeProvider.loadFromLocal();

  runApp(
    MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => resumeProvider),
    ],
      child: MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ATS Friendly CV maker App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen()
    );
  }
}

