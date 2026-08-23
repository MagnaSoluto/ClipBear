import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../constants/app_colors.dart';

enum TinkerState {
  idle,
  happy,
  thinking,
  sleeping,
  celebrating,
  waving,
}

class TinkerAvatar extends StatefulWidget {
  final double size;
  final TinkerState state;
  final bool animate;

  const TinkerAvatar({
    super.key,
    this.size = 200,
    this.state = TinkerState.idle,
    this.animate = true,
  });

  @override
  State<TinkerAvatar> createState() => _TinkerAvatarState();
}

class _TinkerAvatarState extends State<TinkerAvatar>
    with TickerProviderStateMixin {
  late AnimationController _idleController;
  late AnimationController _blinkController;
  late AnimationController _bounceController;
  late Animation<double> _idleAnimation;
  late Animation<double> _blinkAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    if (widget.animate) {
      _startAnimations();
    }
  }

  void _setupAnimations() {
    // Idle breathing animation
    _idleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _idleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _idleController, curve: Curves.easeInOut),
    );

    // Blink animation
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _blinkAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _blinkController, curve: Curves.easeInOut),
    );

    // Bounce animation
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _bounceAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
    );
  }

  void _startAnimations() {
    // Idle loop
    _idleController.repeat(reverse: true);

    // Bounce on mount
    _bounceController.forward();

    // Random blinking
    _scheduleBlink();
  }

  void _scheduleBlink() {
    if (!mounted) return;
    
    final random = math.Random();
    final delay = Duration(milliseconds: 2000 + random.nextInt(3000));
    
    Future.delayed(delay, () {
      if (mounted && widget.animate) {
        _blinkController.forward().then((_) {
          _blinkController.reverse().then((_) => _scheduleBlink());
        });
      }
    });
  }

  @override
  void dispose() {
    _idleController.dispose();
    _blinkController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _idleAnimation,
        _blinkAnimation,
        _bounceAnimation,
      ]),
      builder: (context, child) {
        final idleOffset = math.sin(_idleAnimation.value * math.pi * 2) * 5;
        final scale = _bounceAnimation.value;

        return Transform.translate(
          offset: Offset(0, idleOffset),
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                gradient: AppColors.tinkerGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.tinkerPrimary.withValues(alpha: 0.3),
                    blurRadius: 30,
                    offset: Offset(0, 10 + idleOffset),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Face
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Eyes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildEye(_blinkAnimation.value),
                            SizedBox(width: widget.size * 0.15),
                            _buildEye(_blinkAnimation.value),
                          ],
                        ),
                        SizedBox(height: widget.size * 0.08),
                        // Mouth
                        _buildMouth(),
                      ],
                    ),
                  ),
                  // Expression overlay based on state
                  _buildExpressionOverlay(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEye(double openness) {
    final eyeSize = widget.size * 0.12;
    
    return Container(
      width: eyeSize,
      height: eyeSize * openness,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(eyeSize / 2),
      ),
      child: openness > 0.5
          ? Center(
              child: Container(
                width: eyeSize * 0.5,
                height: eyeSize * 0.5,
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildMouth() {
    final mouthWidth = widget.size * 0.3;
    final mouthHeight = widget.size * 0.15;

    return Container(
      width: mouthWidth,
      height: mouthHeight,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(mouthHeight),
        ),
      ),
    );
  }

  Widget _buildExpressionOverlay() {
    switch (widget.state) {
      case TinkerState.happy:
        return Center(
          child: Text(
            '😊',
            style: TextStyle(fontSize: widget.size * 0.6),
          ),
        );
      case TinkerState.thinking:
        return Positioned(
          top: widget.size * 0.1,
          right: widget.size * 0.1,
          child: Text(
            '💭',
            style: TextStyle(fontSize: widget.size * 0.2),
          ),
        );
      case TinkerState.sleeping:
        return Center(
          child: Text(
            '💤',
            style: TextStyle(fontSize: widget.size * 0.4),
          ),
        );
      case TinkerState.celebrating:
        return Center(
          child: Text(
            '🎉',
            style: TextStyle(fontSize: widget.size * 0.3),
          ),
        );
      case TinkerState.waving:
        return Positioned(
          top: widget.size * 0.2,
          right: widget.size * 0.05,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            builder: (context, value, child) {
              return Transform.rotate(
                angle: math.sin(value * math.pi * 4) * 0.3,
                child: Text(
                  '👋',
                  style: TextStyle(fontSize: widget.size * 0.25),
                ),
              );
            },
          ),
        );
      case TinkerState.idle:
        return const SizedBox.shrink();
    }
  }
}
