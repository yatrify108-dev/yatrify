import 'package:flutter/material.dart';

class HoverZoomImage extends StatefulWidget {
  const HoverZoomImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  State<HoverZoomImage> createState() => _HoverZoomImageState();
}

class _HoverZoomImageState extends State<HoverZoomImage> {
  final ValueNotifier<bool> _hovering = ValueNotifier(false);

  @override
  void dispose() {
    _hovering.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _hovering.value = true,
      onExit: (_) => _hovering.value = false,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: ValueListenableBuilder(
            valueListenable: _hovering,
            builder: (context, isHovering, _) {
              return AnimatedScale(
                scale: isHovering ? 1.05 : 1.0,
                duration: const Duration(microseconds: 200),
                alignment: Alignment.bottomLeft,
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
