import 'package:flutter/material.dart';

class DigitFlipper extends StatefulWidget {
  final int digit;
  final Duration animationDuration;
  final Curve animationCurve;

  const DigitFlipper({
    super.key,
    required this.digit,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOutCubic,
  });

  @override
  _DigitFlipperState createState() => _DigitFlipperState();
}

class _DigitFlipperState extends State<DigitFlipper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  int _oldDigit = -1; // To store the previous digit for animation direction

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _offsetAnimation =
        Tween<Offset>(
          begin: Offset.zero,
          end: Offset.zero, // Will be set dynamically
        ).animate(
          CurvedAnimation(parent: _controller, curve: widget.animationCurve),
        );
    _oldDigit = widget.digit;
  }

  @override
  void didUpdateWidget(covariant DigitFlipper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.digit != oldWidget.digit) {
      _oldDigit = oldWidget.digit;
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: widget.animationDuration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        final double direction = (widget.digit > _oldDigit) ? 1.0 : -1.0;
        final Offset beginOffset = Offset(
          0.0,
          direction,
        ); // Start from above or below
        final Offset endOffset = Offset.zero;

        _offsetAnimation = Tween<Offset>(begin: beginOffset, end: endOffset)
            .animate(
              CurvedAnimation(
                parent: _controller,
                curve: widget.animationCurve,
              ),
            );

        return ClipRRect(
          // Clip to prevent digits from appearing outside their bounds
          child: SlideTransition(position: _offsetAnimation, child: child),
        );
      },
      child: Text(
        '${widget.digit}',
        key: ValueKey<int>(
          widget.digit,
        ), // Important for AnimatedSwitcher to identify changes
        style: const TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
