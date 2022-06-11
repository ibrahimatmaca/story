import 'package:flutter/material.dart';

class StoryFrame extends StatelessWidget {
  const StoryFrame({Key? key, required this.detailShortText}) : super(key: key);

  final String detailShortText;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: -15,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/frame_up.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .75,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/frame_down.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            bottom: 125,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                detailShortText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                child: Image.asset(
                  'assets/images/right.png',
                  scale: 0.9,
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 20,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Detaylı Bilgi için",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
