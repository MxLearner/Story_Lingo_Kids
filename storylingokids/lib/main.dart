import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/views/startup_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) => runApp(const MyApp()),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StoryLingoKids',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFEFEFE),
        fontFamily: 'CabinSketch',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF4B4B4B)),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
