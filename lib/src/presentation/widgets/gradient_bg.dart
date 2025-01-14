import 'package:flutter/material.dart';

class GradientBg extends StatelessWidget {

  final List<Color> colors;
  final List<double> stops;
  
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;

  
  const GradientBg({
    super.key,
    required this.colors,
    required this.stops,
    this.begin,
    this.end
  }):
    assert( colors.length == stops.length, 'La cantidad de items de colors debe ser igual que los stops' );

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            stops: stops,
            begin: begin ?? Alignment.centerLeft,
            end: end ?? Alignment.centerRight,
          )
        )
      ),
    );
  }
}