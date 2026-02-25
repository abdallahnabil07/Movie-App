import 'package:flutter/material.dart';

class GradientCustom extends StatelessWidget {
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;
  final List<double>? stops;

  const GradientCustom({
    super.key,
    required this.colors,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
    this.stops,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            colors: colors,
            stops: stops,
          ),
        ),
      ),
    );
  }
}
