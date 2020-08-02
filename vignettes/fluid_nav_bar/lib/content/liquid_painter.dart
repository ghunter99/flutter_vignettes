import 'dart:math';

import 'package:flutter/material.dart';

class LiquidSimulation {
  int curveCount = 4;
  List<Offset> ctrlPts = [];
  List<Offset> endPts = [];
  List<Animation<double>> ctrlTweens = [];

  double endPtX1 = .5;
  double endPtY1 = 1;
  double duration;
  double time;
  double xOffset = 0;

  final ElasticOutCurve _ease = const ElasticOutCurve(.3);

  double hzScale;
  double hzOffset;

  void start(AnimationController controller, {bool flipY}) {
    //Each time the controller ticks, update our control points, using the latest tween values
    controller.addListener(updateControlPointsFromTweens);
    //Calculate gap between each ctrl/end pt.
    final gap = 1 / (curveCount * 2.0);

    //Randomly scale and offset each simulation, for more variety
    hzScale = 1.25 + Random().nextDouble() * .5;
    hzOffset = -.2 + Random().nextDouble() * .4;

    //Create end points, these sit at yPos=0, and don't animate
    endPts.clear();
    //For n curves, we need n + 2 endpoints
    //Create first end point
    endPts.insert(0, const Offset(0, 0)); //Start at 0,0
    for (var i = 1; i < curveCount; i++) {
      endPts.add(Offset(gap * i * 2, 0));
    }
    //Last endpoint at 1,0
    endPts.add(const Offset(1, 0));

    //Create control points, these animate on the Y axis
    ctrlPts.clear();
    for (var i = 0; i < curveCount + 1; i++) {
      //Choose random height for this control pt
      final height = (.5 + Random().nextDouble() * .5) *
          (i % 2 == 0 ? 1 : -1) *
          (flipY ? -1 : 1);
      //Create a 3 part tween, does nothing for a bit, then easesOut to 'height', then elastic snaps back to 0
      final animSequence = TweenSequence([
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 0),
          weight: 10.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: height)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 10.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: height, end: 0)
              .chain(CurveTween(curve: _ease)),
          weight: 60.0,
        )
      ]).animate(controller);
      ctrlTweens.add(animSequence);
      ctrlPts.add(Offset(gap + gap * i * 2, height));
    }
  }

  List<Offset> updateControlPointsFromTweens() {
    for (var i = 0; i < ctrlPts.length; i++) {
      final o = ctrlPts[i];
      ctrlPts[i] = Offset(o.dx, ctrlTweens[i].value);
    }
    return ctrlPts;
  }
}

class LiquidPainter extends CustomPainter {
  LiquidPainter(this.fillLevel, this.simulation1, this.simulation2,
      {this.waveHeight = 200});

  final double fillLevel;
  final LiquidSimulation simulation1;
  final LiquidSimulation simulation2;
  final double waveHeight;

  @override
  void paint(Canvas canvas, Size size) {
//    _drawLiquidSim(simulation1, canvas, size, 0, Color(0xffC48D3B).withOpacity(.4));
//    _drawLiquidSim(simulation2, canvas, size, 5,  Color(0xff9D7B32).withOpacity(.4));
    _drawLiquidSim(
        simulation1, canvas, size, 0, const Color(0xFFC7EAFF).withOpacity(.6));
    _drawLiquidSim(
        simulation2, canvas, size, 5, const Color(0xFF99D3F7).withOpacity(.6));
//    _drawLiquidSim(
//        simulation1, canvas, size, 0, Colors.lightBlue.withOpacity(.4));
//    _drawLiquidSim(simulation2, canvas, size, 5, Colors.blue.withOpacity(.4));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawLiquidSim(LiquidSimulation simulation, Canvas canvas, Size size,
      double offsetY, Color color) {
    canvas.scale(simulation.hzScale, 1);
    canvas.translate(simulation.hzOffset * size.width, offsetY);

    //_drawOffsets(simulation, canvas, size);

    //Create a path around bottom and sides of card
    final path = Path()
      ..moveTo(size.width * 1.25, 0)
      ..lineTo(size.width * 1.25, size.height)
      ..lineTo(-size.width * .25, size.height)
      ..lineTo(-size.width * .25, 0);

    //Loop through simulation control and end points, drawing each as a pair
    for (var i = 0; i < simulation.curveCount; i++) {
      final ctrlPt = sizeOffset(simulation.ctrlPts[i], size);
      final endPt = sizeOffset(simulation.endPts[i + 1], size);
      path.quadraticBezierTo(ctrlPt.dx, ctrlPt.dy, endPt.dx, endPt.dy);
    }
    canvas.drawPath(path, Paint()..color = color);

    canvas.translate(-simulation.hzOffset * size.width, -offsetY);
    canvas.scale(1 / simulation.hzScale, 1);
  }

  Offset sizeOffset(Offset pt, Size size) {
    return Offset(pt.dx * size.width, waveHeight * pt.dy);
  }
}
