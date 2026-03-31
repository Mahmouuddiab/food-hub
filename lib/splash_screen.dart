import 'package:flutter/material.dart';
import 'package:food_hub/core/utils/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_hub/core/helper/cache_helper.dart';
import 'package:food_hub/root.dart';
import 'features/auth/presentation/screen/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _imageController;
  late AnimationController _scaleController;

  late Animation<double> _logoFadeAnimation;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<double> _logoScaleAnimation;

  late Animation<double> _imageFadeAnimation;
  late Animation<Offset> _imageSlideAnimation;

  late Animation<double> _backgroundScaleAnimation;

  @override
  void initState() {
    super.initState();

    // Logo animations controller
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Image animations controller
    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Background scale controller
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Logo fade animation
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Logo slide from top
    _logoSlideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _logoController,
            curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
          ),
        );

    // Logo scale animation (bounce effect)
    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
      ),
    );

    // Image fade animation
    _imageFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.easeIn),
    );

    // Image slide from bottom
    _imageSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _imageController, curve: Curves.easeOutCubic),
        );

    // Background subtle scale animation
    _backgroundScaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    // Start animations sequence
    _startAnimations();
  }

  Future<void> _startAnimations() async {
    // Start background subtle scale
    _scaleController.forward();

    // Start logo animation
    await _logoController.forward();

    // Start image animation
    await _imageController.forward();

    // Optional delay after animations
    await Future.delayed(const Duration(seconds: 1));

    // Navigate based on cached user ID
    final userId = CacheHelper.getUserId();
    if (!mounted) return;

    if (userId != null && userId.isNotEmpty) {
      // User is logged in → go to Root screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Root()),
      );
    } else {
      // User not logged in → go to Login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _imageController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedBuilder(
            animation: _scaleController,
            builder: (context, child) {
              return Transform.scale(
                scale: _backgroundScaleAnimation.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    // Animated Logo
                    SlideTransition(
                      position: _logoSlideAnimation,
                      child: FadeTransition(
                        opacity: _logoFadeAnimation,
                        child: ScaleTransition(
                          scale: _logoScaleAnimation,
                          child: SvgPicture.asset(
                            "assets/Hungry_.svg",
                            width: 258,
                            height: 60,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Animated Splash Image
                    SlideTransition(
                      position: _imageSlideAnimation,
                      child: FadeTransition(
                        opacity: _imageFadeAnimation,
                        child: Image.asset(
                          "assets/burger.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}