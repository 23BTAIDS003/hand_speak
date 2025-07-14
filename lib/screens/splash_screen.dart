import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _progressController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  double _progress = 0.0;
  int _loadingPhase = 0;

  final List<String> _loadingTexts = [
    "Initializing...",
    "Loading assets...",
    "Setting up AI...",
    "Almost there..."
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    _logoController.forward();
    _progressController.addListener(_handleProgress);
    _progressController.forward();

    _startLoadingPhases();
  }

  void _handleProgress() {
    setState(() {
      _progress = _progressController.value;
    });
    if (_progressController.isCompleted) {
      _navigateNext();
    }
  }

  void _startLoadingPhases() async {
    for (int i = 0; i < _loadingTexts.length; i++) {
      await Future.delayed(const Duration(milliseconds: 700));
      setState(() {
        _loadingPhase = i;
      });
    }
  }

  Future<void> _navigateNext() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;
    final isAuthenticated = FirebaseAuth.instance.currentUser != null;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
      Navigator.pushReplacementNamed(context, '/signup');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          body: Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colors.primary, colors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogoSection(colors),
                  SizedBox(height: 3.h),
                  _buildAppTitle(colors),
                  SizedBox(height: 1.5.h),
                  _buildTagline(colors),
                  SizedBox(height: 8.h),
                  _buildLoadingText(colors),
                  const Spacer(),
                  _buildProgressBar(colors),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogoSection(ColorScheme colors) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [colors.primary, colors.secondary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withOpacity(0.3),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      padding: EdgeInsets.all(4.5.h),
      child: _buildAnimatedLogo(colors),
    );
  }

  Widget _buildAnimatedLogo(ColorScheme colors) {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 13.h,
              height: 13.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [colors.secondary, colors.primary.withOpacity(0.8)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.pan_tool_rounded,
                  size: 7.h,
                  color: colors.onPrimary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppTitle(ColorScheme colors) {
    return Text(
      "HandSpeak",
      style: TextStyle(
        fontSize: 5.5.h,
        fontWeight: FontWeight.bold,
        color: colors.onPrimary,
        letterSpacing: 1.2,
        shadows: [
          Shadow(
            color: colors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }

  Widget _buildTagline(ColorScheme colors) {
    return Text(
      "Learn Sign Language with AI",
      style: TextStyle(
        fontSize: 2.2.h,
        fontWeight: FontWeight.w400,
        color: colors.onSecondary,
        letterSpacing: 0.8,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLoadingText(ColorScheme colors) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: Text(
        _loadingTexts[_loadingPhase],
        key: ValueKey(_loadingPhase),
        style: TextStyle(
          fontSize: 2.1.h,
          color: colors.onPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildProgressBar(ColorScheme colors) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: LinearProgressIndicator(
          value: _progress,
          backgroundColor: colors.surface.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(colors.secondary),
          minHeight: 1.7.h,
        ),
      ),
    );
  }
}
