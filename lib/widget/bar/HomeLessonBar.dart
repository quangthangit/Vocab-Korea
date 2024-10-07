import 'package:flutter/material.dart';

class HomeLessonBar extends StatelessWidget {
  const HomeLessonBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            child: const Icon(Icons.arrow_back_sharp),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Row(
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
