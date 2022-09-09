import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///https://stackoverflow.com/questions/62620579/how-to-use-mix-blend-mode-in-flutter
class BlendMask extends SingleChildRenderObjectWidget {
  final BlendMode blendMode;
  final double opacity;

  const BlendMask({
    required this.blendMode,
    this.opacity = 1.0,
    Key? key,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(context) {
    return CustomBlendMask(blendMode, opacity);
  }

  @override
  void updateRenderObject(BuildContext context, CustomBlendMask renderObject) {
    renderObject.blendMode = blendMode;
    renderObject.opacity = opacity;
  }
}

class CustomBlendMask extends RenderProxyBox {
  BlendMode blendMode;
  double opacity;

  CustomBlendMask(this.blendMode, this.opacity);

  @override
  void paint(context, offset) {
    context.canvas.saveLayer(
        offset & size,
        Paint()
          ..blendMode = blendMode
          ..color = Color.fromARGB((opacity * 255).round(), 255, 255, 255));

    super.paint(context, offset);
    context.canvas.restore();
  }
}
