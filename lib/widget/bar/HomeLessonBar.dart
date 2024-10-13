import 'package:flutter/material.dart';

class HomeLessonBar extends StatelessWidget {
  const HomeLessonBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share)
              ),
              const SizedBox(width: 10,),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert)
              )
            ],
          )
        ],
      ),
    );
  }
}
