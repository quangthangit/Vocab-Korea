import 'package:flutter/material.dart';

class HomeLessonBar extends StatelessWidget {
  const HomeLessonBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.arrow_back_sharp),
          Row(
            children: [
              Icon(Icons.share),
              Icon(Icons.more_vert)
            ],
          )
        ],
      ),
    );
  }
}
