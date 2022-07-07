import 'package:flutter/material.dart';

import 'measure_size.dart';

class ContentLimitter extends StatefulWidget {
  final Widget child;
  final double maxHeight;
  final double fadeEffectHeight;

  const ContentLimitter(
      {required this.maxHeight,
      required this.child,
      this.fadeEffectHeight = 72});

  @override
  _ContentLimitterState createState() => _ContentLimitterState();
}

class _ContentLimitterState extends State<ContentLimitter> {
  var _size = Size.zero;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: widget.maxHeight,
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MeasureSize(
              onChange: (size) => setState(() => _size = size),
              child: widget.child,
            ),
          ),
          if (_size.height >= widget.maxHeight)
            Positioned(
              bottom: 0,
              left: 0,
              width: _size.width,
              child: _buildOverflowIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildOverflowIndicator() {
    return Container(
      height: widget.fadeEffectHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.white.withAlpha(200),
            Colors.white.withAlpha(0),
          ],
          tileMode: TileMode.clamp,
        ),
      ),
    );
  }
}
