import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';

class CustomMarquee extends StatefulWidget {
  final String rate;
  const CustomMarquee({super.key, required this.rate});

  @override
  State<CustomMarquee> createState() => _CustomMarqueeState();
}

class _CustomMarqueeState extends State<CustomMarquee>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // Total duration: enter + pause + exit
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // Keyframes: right → center (3s), pause (1s), center → left (3s)
    _animation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 3,
      ),
      TweenSequenceItem(
        tween: ConstantTween<Offset>(Offset.zero), // pause
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0.0, 0.0),
          end: const Offset(-1.0, 0.0),
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 3,
      ),
    ]).animate(_controller);

    _controller.repeat(); // continuous animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildContent() {
    return Row(
      children: [
        const SizedBox(width: 10),
        Image.asset("assets/icon/google.png", width: 12, height: 12),
        const SizedBox(width: 4),
        const Icon(Icons.star, color: Colors.orange, size: 16),
        const SizedBox(width: 6),
        Text(
          "Rated ${widget.rate} on Google",
          style: context.style.bodySmall!.copyWith(color: context.scheme.outline, fontSize: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: double.infinity,
      child: ClipRect(
        child: SlideTransition(
          position: _animation,
          child: SizedBox(width: 260, child: _buildContent()),
        ),
      ),
    );
  }
}
