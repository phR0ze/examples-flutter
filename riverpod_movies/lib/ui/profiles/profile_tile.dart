import 'package:flutter/material.dart';
import '../../data/model/exports.dart';

class ProfileTile extends StatelessWidget {
  final Profile profile;
  final bool selected;
  final VoidCallback? onPressed;

  const ProfileTile({
    super.key,
    required this.profile,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ProfileFaceBox(selected: selected),
            ),
            const SizedBox(height: 8.0),
            Text(profile.name),
          ],
        ));
  }
}

class ProfileFaceBox extends StatelessWidget {
  final bool selected;
  const ProfileFaceBox({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo,
            Colors.indigo[700]!,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: CustomPaint(painter: FaceOutlinePainter(selected)),
    );
  }
}

// Generate a face outline
class FaceOutlinePainter extends CustomPainter {
  FaceOutlinePainter(this.selected);
  final bool selected;

  @override
  void paint(Canvas canvas, Size size) {
    // Define a paint object
    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    final eyeWidth = 0.1 * size.width;
    final eyeHeight = 0.1 * size.height;

    // Left eye
    canvas.drawOval(
      Rect.fromLTWH(0.2 * size.width, 0.3 * size.height, eyeWidth, eyeHeight),
      fillPaint,
    );

    // Right eye
    canvas.drawOval(
      Rect.fromLTWH(0.7 * size.width, 0.3 * size.height, eyeWidth, eyeHeight),
      fillPaint,
    );

    // Configure pait brush
    var strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.white;

    // Mouth
    final mouth = Path();
    mouth.moveTo(size.width * 0.3, size.height * 0.6);
    mouth.arcToPoint(
      Offset(size.width * 0.7, size.height * 0.6),
      radius: const Radius.circular(50),
      clockwise: false,
    );

    canvas.drawPath(mouth, strokePaint);

    // Draw a border around the face
    if (selected) {
      strokePaint.color = Colors.blue;
      canvas.drawRect(Rect.fromLTWH(2, 2, size.width - 4, size.height - 4), strokePaint);
    }
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => true;
}
