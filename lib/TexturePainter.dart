import 'dart:ui';
import 'package:flutter/material.dart' hide Image;

// [CustomPainter] painting the texture effect on the screen
//
// Used for the [BlendMode] effect it provides
class TexturePainter extends CustomPainter {
  // Cosntructor accepting [dart:ui.Image]s for the texture
  TexturePainter({required this.screenTexture, required this.multiplyTexture});

  final Paint screenPaint = Paint()..blendMode = BlendMode.screen;

  final Paint multiplyPaint = Paint()..blendMode = BlendMode.multiply;

  final Image screenTexture;
  final Image multiplyTexture;

  @override
  void paint(Canvas canvas, Size size) {
    // Get the first image size
    final screenImageSize = Size(
      screenTexture.width.toDouble(),
      screenTexture.height.toDouble(),
    );
    final screenSrc = Offset.zero & screenImageSize;
    // Get the screen size
    final dst = Offset.zero & size;

    // Fit the image in the screen size and paint
    canvas.drawImageRect(screenTexture, screenSrc, dst, screenPaint);

    // Get the second image size
    final multiplyImageSize = Size(
      multiplyTexture.width.toDouble(),
      multiplyTexture.height.toDouble(),
    );
    final multiplySrc = Offset.zero & multiplyImageSize;

    // Fit the image in the screen and paint
    canvas.drawImageRect(multiplyTexture, multiplySrc, dst, multiplyPaint);
  }

  @override
  bool shouldRepaint(TexturePainter oldDelegate) {
    // Only repaint when the textures themselves are swapped out.
    return oldDelegate.screenTexture != screenTexture ||
        oldDelegate.multiplyTexture != multiplyTexture;
  }
}
