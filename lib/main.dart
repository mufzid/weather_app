import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/src/screens/loginscreen.dart';
import 'package:weather_app/src/screens/splash_screen.dart';
import 'package:weather_app/src/screens/user_form_screen.dart';
import 'package:weather_app/src/screens/user_list_screen.dart';
import 'package:weather_app/src/screens/weather_screen.dart';
import 'package:weather_app/src/screens/welcome_screen.dart';
import 'package:weather_app/src/services/auth_provider';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather App',
            initialRoute: '/',
            routes: {
              '/welcome': (context) => const WelcomeScreen(),
              '/login': (context) => const LoginScreen(),
              '/list': (context) => const UserListScreen(),
              '/form': (context) => const UserFormScreen(),
              '/weather': (context) => const WeatherScreen(),
            },
            home: const SplashScreen()));
  }
}
