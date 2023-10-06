import 'package:flutter/material.dart';
import 'dart:math';

class BackgroundPainter extends CustomPainter {
  final Animation listenable;
  final int page;
  final int prevPage;
  static List<Offset> stars = [];

  BackgroundPainter(
      {required this.listenable, required this.page, required this.prevPage})
      : super(repaint: listenable);

  @override
  void paint(Canvas canvas, Size size) {
    var startX = size.width * prevPage;
    var currentX = (size.width * page) - startX;
    var x = startX + (currentX * listenable.value);
    canvas.translate(-x, 0);

    // 첫 번째 원형 그라디언트 설정
    const Gradient radialGradient1 = RadialGradient(
      center: Alignment(0, 0),
      radius: 0.5,
      colors: [Colors.red, Colors.blue, Colors.green],
      stops: [0.0, 0.5, 1.0],
    );

    // 두 번째 원형 그라디언트 설정
    const Gradient radialGradient2 = RadialGradient(
      center: Alignment(0.5, 0.5),
      radius: 1.2,
      colors: [Colors.yellow, Colors.purple],
      stops: [0.0, 1.0],
    );

    // 그라디언트를 적용할 사각형을 정의합니다.
    Rect rect = Rect.fromLTWH(0, 0, size.width * 3, size.height);

    // 첫 번째 그라디언트 적용
    final Paint paint1 = Paint()..shader = radialGradient1.createShader(rect);
    canvas.drawRect(rect, paint1);

    // 두 번째 그라디언트 적용
    final Paint paint2 = Paint()..shader = radialGradient2.createShader(rect);
    canvas.drawRect(rect, paint2);

    // 랜덤 위치에 별 모양 심볼 그리기
    final Paint starPaint = Paint()..color = Colors.white.withOpacity(0.7);

    // 최초에 한번만 별 모양 좌표 생성하고 그리기
    if (stars.isEmpty) {
      final Random random = Random();
      for (int i = 0; i < 50; i++) {
        final double x = random.nextDouble() * size.width * 3;
        final double y = random.nextDouble() * size.height;
        stars.add(Offset(x, y));
      }
    }
    for (var offset in stars) {
      drawStar(canvas, starPaint, offset.dx, offset.dy, 5, 15, 7);
    }
  }

  // 별 모양을 그리는 함수
  void drawStar(Canvas canvas, Paint paint, double x, double y, int spikes,
      double outerRadius, double innerRadius) {
    final List<Offset> vertices = [];
    final double step = pi / spikes;
    double rotation = pi / 2 * 3;
    for (int i = 0; i < spikes; i++) {
      vertices.add(Offset(
          x + cos(rotation) * outerRadius, y + sin(rotation) * outerRadius));
      rotation += step;
      vertices.add(Offset(
          x + cos(rotation) * innerRadius, y + sin(rotation) * innerRadius));
      rotation += step;
    }
    vertices.add(vertices[0]);
    canvas.drawPath(Path()..addPolygon(vertices, true), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
