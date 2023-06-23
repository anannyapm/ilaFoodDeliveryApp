/* import 'package:flutter/material.dart';

class tey extends StatelessWidget {
  const tey({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 122,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 60,
              height: 60,
              decoration: ShapeDecoration(
                image: const DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/60x60"),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const Positioned(
            left: 74,
            top: 8,
            child: Text(
              'Arabian Hut',
              style: TextStyle(
                color: Color(0xFF181C2E),
                fontSize: 14,
                fontFamily: 'Sen',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Positioned(
            left: 271,
            top: 8,
            child: Text(
              '#162432',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF6B6E82),
                fontSize: 14,
                fontFamily: 'Sen',
                fontWeight: FontWeight.w400,
                textDecoration: TextDecoration.underline,
              ),
            ),
          ),
          Positioned(
            left: 74,
            top: 35,
            child: Container(
              width: 111,
              height: 17,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '₹580',
                    style: TextStyle(
                      color: Color(0xFF181C2E),
                      fontSize: 14,
                      fontFamily: 'Sen',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(0.0, 0.0)
                      ..rotateZ(1.57),
                    child: Container(
                      width: 16,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.50,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFCACCD9),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '03 Items',
                        style: TextStyle(
                          color: Color(0xFF6B6E81),
                          fontSize: 12,
                          fontFamily: 'Sen',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 188,
            top: 84,
            child: Container(
              width: 139,
              height: 38,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 139,
                      height: 38,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 0.50,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFFF7621),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 50,
                    top: 12,
                    child: Text(
                      'Cancel',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFF7621),
                        fontSize: 12,
                        fontFamily: 'Sen',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 84,
            child: Container(
              width: 139,
              height: 38,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 139,
                      height: 38,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1AD52B),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 35,
                    top: 12,
                    child: Text(
                      'Track Order',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Sen',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 */