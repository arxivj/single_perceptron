import 'dart:math';

import 'package:flutter/material.dart';

class PerceptronGraph extends CustomPainter {
  final int w1, w2, bias;
  final Point<int> selectedPoint;

  PerceptronGraph({
    required this.w1,
    required this.w2,
    required this.bias,
    required this.selectedPoint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double scale = size.width / 4;

    double toScreenX(num logicalX) => centerX + logicalX * scale;
    double toScreenY(num logicalY) => centerY - logicalY * scale;

    const double smallThreshold = 0.001;
    const double selectedPointRadius = 8.0;
    const double defaultPointRadius = 4.0;

    // x, y축 페인팅
    final axisPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(0, centerY), Offset(size.width, centerY), axisPaint);
    canvas.drawLine(Offset(centerX, 0), Offset(centerX, size.height), axisPaint);

    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // 결정 경계 페인팅
    final linePaint = Paint()
      ..color = Colors.grey.shade600
      ..strokeWidth = 2.0;

    if (w1.abs() > smallThreshold || w2.abs() > smallThreshold) {
      if (w2.abs() > w1.abs()) {
        /*
    * 결정 경계(Decision Boundary)의 두 끝점 (x₁, y₁)과 (x₂, y₂)를 계산한다.
    *
    * 1. 좌표계 변환 공식 정의
    * 화면 좌표(screen_x)와 논리 좌표(logical_x) 간의 선형 변환 관계는 다음과 같이 정의된다:
    * screen_x = centerX + (logical_x * scale)
    *
    * 2. 논리 좌표 공식 유도
    * 위 변환 공식을 logical_x에 대하여 정리하면 다음과 같다:
    * logical_x = (screen_x - centerX) / scale
    *
    * 3. 양 끝점의 x좌표 계산
    * 화면의 좌측(screen_x = 0)과 우측(screen_x = size.width) 경계에 해당하는
    * 논리 좌표 x₁과 x₂는 다음과 같이 계산된다.
    * - x₁ = (0 - centerX) / scale = -centerX / scale
    * - x₂ = (size.width - centerX) / scale
    * (단, size.width = 2 * centerX 이므로)
    * = (2 * centerX - centerX) / scale = centerX / scale
    */
        double x1 = -centerX / scale;
        double x2 = centerX / scale;

        /*
    * 4. 양 끝점의 y좌표 계산
    * 결정 경계의 선형 방정식 w₁x + w₂y + b = 0을 y에 대하여 정리하면,
    * y = -(w₁x + b) / w₂ 가 유도된다.
    * 위 식에 계산된 x₁, x₂를 각각 대입하여 y₁, y₂를 구한다.
    */
        double y1 = -(w1 * x1 + bias) / w2;
        double y2 = -(w1 * x2 + bias) / w2;
        canvas.drawLine(
          Offset(toScreenX(x1), toScreenY(y1)),
          Offset(toScreenX(x2), toScreenY(y2)),
          linePaint,
        );
      } else {
        double y1 = -centerY / scale;
        double y2 = centerY / scale;
        double x1 = -(w2 * y1 + bias) / w1;
        double x2 = -(w2 * y2 + bias) / w1;
        canvas.drawLine(
          Offset(toScreenX(x1), toScreenY(y1)),
          Offset(toScreenX(x2), toScreenY(y2)),
          linePaint,
        );
      }
    }
    canvas.restore();

    // 포인트 페인팅
    final points = [const Point(1, 1), const Point(1, -1), const Point(-1, 1), const Point(-1, -1)];
    for (final point in points) {
      int result = w1 * point.x + w2 * point.y + bias;
      bool isCurrentPoint = (point == selectedPoint);
      double radius = isCurrentPoint ? selectedPointRadius : defaultPointRadius;

      final pointPaint = Paint()..color = result >= 0 ? Colors.green : Colors.red;
      canvas.drawCircle(Offset(toScreenX(point.x), toScreenY(point.y)), radius, pointPaint);
      if (isCurrentPoint) {
        final borderPaint = Paint()
          ..color = Colors.yellowAccent
          ..strokeWidth = 3.0
          ..style = PaintingStyle.stroke;
        canvas.drawCircle(Offset(toScreenX(point.x), toScreenY(point.y)), radius, borderPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant PerceptronGraph oldDelegate) {
    return oldDelegate.w1 != w1 ||
        oldDelegate.w2 != w2 ||
        oldDelegate.bias != bias ||
        oldDelegate.selectedPoint != selectedPoint;
  }
}
