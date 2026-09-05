import 'dart:ui';

import 'package:humanbeans_clock/ClockUiInheritedModel.dart';
import 'package:humanbeans_clock/LayersLayout.dart';
import 'package:humanbeans_clock/LoadingScreen.dart';
import 'package:humanbeans_clock/TexturePainter.dart';
import 'package:flutter/material.dart' hide Image;

// Class to wrap all the display widgets in [AspectRatio] and hold the [FutureBuilder].
//
// The [FutureBuilder] resolves when the [dart:ui.Image] load and dispalys the clock face.
// Before that shows a loading screen
class SceneLayout extends StatelessWidget {
  const SceneLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 5 / 3,
        child: FutureBuilder<List<Image>>(
          // Subscibes to the 'iamgesFuture' to the [ClockUiInheritedModel]. Should't trigger
          // rebuild.
          future: ClockUiInheritedModel.of(context, 'imagesFuture').imagesFuture,
          // Resolves when the [dart:ui.Image] load
          builder: (BuildContext c, AsyncSnapshot<List<Image>> snapshot) {
            final images = snapshot.data;
            // If the future has resolved
            if (snapshot.connectionState == ConnectionState.done &&
                images != null) {
              return
              // Paint the textures over all the ui widgets
              // We use [CustomPaint] to get the [ColorBlend] mode for
              // the textures
              CustomPaint(
                foregroundPainter: TexturePainter(
                  screenTexture: images[0],
                  multiplyTexture: images[1],
                ),
                child: const LayersLayout(),
              );
              // If still loading
            } else {
              // Display the loading screen
              return const LoadingScreen();
            }
          },
        ),
      ),
    );
  }
}
