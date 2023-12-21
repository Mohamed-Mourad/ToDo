import 'package:flutter/material.dart';

// Gradient Icon Class

class GradientIcon extends StatelessWidget {
  GradientIcon(
      this.icon,
      this.size,
      this.gradient,
      );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}

// Gradien 1
class IconSample extends StatelessWidget {
  final IconData icon;

  IconSample({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GradientIcon(
      icon,
      30.0,
      const LinearGradient(
        colors: <Color>[
          Color(0xFF6588CD),
          Color(0xFF49CAF2),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
    );
  }
}