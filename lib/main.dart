import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'core/license.dart';
import 'providers/app_state.dart';
import 'screens/activation_screen.dart';
import 'screens/main_wrapper.dart'; // سننشئه لاحقاً

void main() {
  runApp(const MamaxApp());
}

class MamaxApp extends StatelessWidget {
  const MamaxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState()..load(),
      child: MaterialApp(
        title: 'MAMX',
        theme: AppTheme.themeData,
        debugShowCheckedModeBanner: false,
        home: const SplashAndAuth(),
      ),
    );
  }
}

class SplashAndAuth extends StatefulWidget {
  const SplashAndAuth({super.key});

  @override
  State<SplashAndAuth> createState() => _SplashAndAuthState();
}

class _SplashAndAuthState extends State<SplashAndAuth> {
  bool _showSplash = true;
  bool _isActivated = false;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // 1. الانتظار لمدة ثانيتين (شاشة البداية)
    await Future.delayed(const Duration(milliseconds: 2000));
    
    // 2. التحقق من التفعيل
    final activated = await LicenseManager.isActivated();
    
    if (mounted) {
      setState(() {
        _showSplash = false;
        _isActivated = activated;
        _isChecking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // شاشة البداية (Splash)
    if (_showSplash) {
      return Scaffold(
        backgroundColor: const Color(0xFF061325), // لون الخلفية المطابق للـ HTML
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // شعار مؤقت (يمكنك استبداله بصورة لاحقاً)
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'MAMX',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // التحقق من التفعيل
    if (_isChecking) {
      return const Scaffold(
        backgroundColor: AppTheme.bg,
        body: Center(child: CircularProgressIndicator(color: AppTheme.gold)),
      );
    }

    // إذا لم يتم التفعيل -> شاشة التفعيل
    if (!_isActivated) {
      return ActivationScreen(
        onActivated: () {
          setState(() {
            _isActivated = true;
          });
        },
      );
    }

    // إذا تم التفعيل -> التطبيق الرئيسي
    return const MainWrapper();
  }
}
