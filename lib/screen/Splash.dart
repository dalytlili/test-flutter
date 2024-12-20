import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:front_flutter/screen/nav_bar-screen.dart';
import 'package:front_flutter/screen/welcome_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front_flutter/screen/constants.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await _secureStorage.read(key: 'isLoggedIn');

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isLoggedIn != null ? const BottomNavBar() : const WelcomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSplashScreen(
          splash: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/log.png',
                width: 270, // Taille du logo
                height: 270,
              ),
            
            ],
          ),
          nextScreen: const SizedBox.shrink(), // Écran de transition
          splashTransition: SplashTransition.scaleTransition,
          backgroundColor: kprimaryColor,
          splashIconSize: 450,
        ),
      ),
    );
  }
}
