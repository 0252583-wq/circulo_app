import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// MODELOS
import 'plan_vida/models/plan_vida_section.dart';

// PÁGINAS
import 'menu/menu_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ================= HIVE =================
  await Hive.initFlutter();

  // Registrar adapter SOLO si no está registrado
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(PlanVidaSectionAdapter());
  }

  // Abrir caja
  await Hive.openBox<PlanVidaSection>('plan_vida');

  runApp(const CirculoApp());
}

// ================= APP PRINCIPAL =================

class CirculoApp extends StatelessWidget {
  const CirculoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Círculo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Georgia',
      ),
      home: const SplashScreen(),
    );
  }
}

// ================= SPLASH SCREEN =================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (_, __, ___) => const MenuPage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EC),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.contain,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                'Buscando la Santidad\nen lo ordinario',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                  color: const Color(0xFFF8F6F1),
                  shadows: [
                    Shadow(
                      blurRadius: 6,
                      offset: Offset(0, 2),
                      color: Colors.black.withOpacity(0.35),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
