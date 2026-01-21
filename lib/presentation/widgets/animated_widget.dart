import 'package:flutter/material.dart';
import 'package:expense_tracker/core/config/app_dimensions.dart';

class AnimatedSlideInUp extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;

  const AnimatedSlideInUp({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<AnimatedSlideInUp> createState() => _AnimatedSlideInUpState();
}

class _AnimatedSlideInUpState extends State<AnimatedSlideInUp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}

class AnimatedSlideInDown extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;

  const AnimatedSlideInDown({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<AnimatedSlideInDown> createState() => _AnimatedSlideInDownState();
}

class _AnimatedSlideInDownState extends State<AnimatedSlideInDown>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}

class AnimatedSlideInRight extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;

  const AnimatedSlideInRight({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<AnimatedSlideInRight> createState() => _AnimatedSlideInRightState();
}

class AnimatedSlideInLeft extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;

  const AnimatedSlideInLeft({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<AnimatedSlideInLeft> createState() => _AnimatedSlideInLeftState();
}

class _AnimatedSlideInRightState extends State<AnimatedSlideInRight>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.25, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}

class _AnimatedSlideInLeftState extends State<AnimatedSlideInLeft>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.25, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}

class AnimatedProgressStepper extends StatefulWidget {
  final int totalSteps;
  final int currentStep;

  const AnimatedProgressStepper({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  State<AnimatedProgressStepper> createState() =>
      _AnimatedProgressStepperState();
}

class _AnimatedProgressStepperState extends State<AnimatedProgressStepper> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.totalSteps, (index) {
        final bool isCompleted = index < widget.currentStep - 1;
        final bool isActive = index == widget.currentStep - 1;

        return Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              width: isActive ? 24.0 : 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: isCompleted || isActive
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).disabledColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            if (index < widget.totalSteps - 1)
              SizedBox(width: AppDimensions.spaceXS),
          ],
        );
      }),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color color;
  final Duration duration;

  const AnimatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    required this.color,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
        _isPressed = true;
        setState(() {});
      },
      onTapUp: (_) {
        _controller.reverse();
        _isPressed = false;
        setState(() {});
        widget.onPressed?.call();
      },
      onTapCancel: () {
        _controller.reverse();
        _isPressed = false;
        setState(() {});
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: widget.duration,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            boxShadow: _isPressed
                ? []
                : [
                    BoxShadow(
                      color: widget.color.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
