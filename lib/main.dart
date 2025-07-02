import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:single_perceptron/features/selection/selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Single Perceptron',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[300],
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          primary: Colors.grey.shade800,
          secondary: Colors.grey.shade600,
          surface: Colors.grey.shade300,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: Colors.grey[700],
          inactiveTrackColor: Colors.grey[400],
        ),
      ),
      home: const SelectionScreen(),
    );
  }
}
